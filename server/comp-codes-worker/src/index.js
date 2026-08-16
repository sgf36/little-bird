/**
 * Complimentary unlock codes for Wren.
 *
 * Wren's paid feature is a one-time purchase. This lets a named person — a
 * friend, a tester, App Review — have it without paying, using a code that
 * works once and then does not.
 *
 * The reason this is a server at all: single use cannot be enforced on the
 * device. A code could be signed and checked offline with an embedded public
 * key, needing nothing here, but then one code pasted into a group chat
 * unlocks the app for everyone who reads it, and nothing on a phone can know a
 * code has already been spent somewhere else. "Already redeemed" is a fact
 * that has to live in one place.
 *
 * What the app gets back is an Ed25519-signed token naming the device. That
 * matters twice over: the app checks its entitlement offline forever after,
 * and pointing the app at a look-alike server achieves nothing, because a
 * forged "yes" cannot carry a valid signature.
 */

const CORS = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'POST, GET, OPTIONS',
  'Access-Control-Allow-Headers': 'Content-Type, Authorization',
};

const json = (body, status = 200) =>
  new Response(JSON.stringify(body), {
    status,
    headers: { 'Content-Type': 'application/json', ...CORS },
  });

/** Unambiguous alphabet: no 0/O, no 1/I/L, no U. 30 symbols. */
const ALPHABET = '23456789ABCDEFGHJKMNPQRSTVWXYZ';

/** Sixteen symbols is about 78 bits, which is not guessable. */
function mintCode() {
  const bytes = crypto.getRandomValues(new Uint8Array(16));
  let out = '';
  for (let i = 0; i < 16; i++) {
    if (i && i % 4 === 0) out += '-';
    out += ALPHABET[bytes[i] % ALPHABET.length];
  }
  return out;
}

/**
 * Accepts what a person actually types: lower case, spaces, missing or extra
 * hyphens. Rejecting a correct code over a stray space is a support email.
 */
function normalise(raw) {
  return String(raw || '').toUpperCase().replace(/[^0-9A-Z]/g, '');
}

const grouped = (bare) => bare.match(/.{1,4}/g)?.join('-') ?? bare;

const b64url = (bytes) =>
  btoa(String.fromCharCode(...new Uint8Array(bytes)))
    .replace(/\+/g, '-').replace(/\//g, '_').replace(/=+$/, '');

async function signingKey(env) {
  const pkcs8 = Uint8Array.from(atob(env.WREN_SIGNING_KEY), (c) =>
    c.charCodeAt(0));
  return crypto.subtle.importKey('pkcs8', pkcs8, { name: 'Ed25519' }, false,
    ['sign']);
}

/**
 * `payload.signature`, both base64url. The device id is inside the signed
 * payload, so a token lifted off one phone is worthless on another.
 */
async function issueToken(env, device, code) {
  const payload = JSON.stringify({
    v: 1,
    d: device,
    c: code,
    t: Math.floor(Date.now() / 1000),
  });
  const body = new TextEncoder().encode(payload);
  const sig = await crypto.subtle.sign({ name: 'Ed25519' },
    await signingKey(env), body);
  return `${b64url(body)}.${b64url(sig)}`;
}

/** Codes are 78 bits, so this is a lid on noise rather than a real defence. */
const WINDOW_SECONDS = 600;
const MAX_FAILURES = 20;

/** Nothing is kept longer than this, and the privacy policy says so. */
const KEEP_ATTEMPTS_SECONDS = 3600;

async function tooManyFailures(env, ip) {
  const now = Math.floor(Date.now() / 1000);
  // Swept on the way in, on every redemption rather than only on failures.
  // Previously the sweep rode along with the insert, so a run of failures
  // followed by silence left those addresses sitting there indefinitely —
  // which is not what "deleted after an hour" means.
  await env.DB.prepare('DELETE FROM attempts WHERE at < ?1')
    .bind(now - KEEP_ATTEMPTS_SECONDS).run();
  const row = await env.DB.prepare(
    'SELECT COUNT(*) AS n FROM attempts WHERE ip = ?1 AND at > ?2')
    .bind(ip, now - WINDOW_SECONDS).first();
  return (row?.n ?? 0) >= MAX_FAILURES;
}

async function recordFailure(env, ip) {
  // Only failures, and only the address — never joined to the code that was
  // tried or to the device that tried it.
  await env.DB.prepare('INSERT INTO attempts (ip, at) VALUES (?1, ?2)')
    .bind(ip, Math.floor(Date.now() / 1000)).run();
}

async function redeem(request, env) {
  const ip = request.headers.get('CF-Connecting-IP') ?? 'unknown';
  let body;
  try {
    body = await request.json();
  } catch {
    return json({ error: 'bad_request' }, 400);
  }

  const code = normalise(body.code);
  const device = String(body.device || '').slice(0, 128);
  if (code.length !== 16 || !device) {
    return json({ error: 'bad_request' }, 400);
  }
  if (await tooManyFailures(env, ip)) {
    return json({ error: 'rate_limited' }, 429);
  }

  const now = Math.floor(Date.now() / 1000);

  // One statement decides everything, which is the point. The row is written
  // only if the code exists, is live, and has spare uses; ON CONFLICT makes a
  // repeat from the same device a no-op rather than a second use. Splitting
  // this into a check and then a write would let two simultaneous redemptions
  // of a one-use code both pass the check.
  await env.DB.prepare(`
    INSERT INTO redemptions (code, device, redeemed_at)
    SELECT ?1, ?2, ?3 FROM codes
     WHERE code = ?1
       AND revoked = 0
       AND (expires_at IS NULL OR expires_at > ?3)
       AND (SELECT COUNT(*) FROM redemptions WHERE code = ?1) < max_uses
    ON CONFLICT (code, device) DO NOTHING
  `).bind(code, device, now).run();

  const held = await env.DB.prepare(
    'SELECT 1 FROM redemptions WHERE code = ?1 AND device = ?2')
    .bind(code, device).first();

  if (!held) {
    await recordFailure(env, ip);
    // Deliberately one reason for every refusal. Telling a stranger that a
    // code is real but spent confirms the code is real.
    return json({ error: 'invalid_code' }, 403);
  }

  return json({ token: await issueToken(env, device, code) });
}

function authorised(request, env) {
  const header = request.headers.get('Authorization') ?? '';
  const given = header.replace(/^Bearer\s+/i, '');
  const want = env.ADMIN_TOKEN ?? '';
  if (!want || given.length !== want.length) return false;
  let diff = 0;
  for (let i = 0; i < want.length; i++) {
    diff |= given.charCodeAt(i) ^ want.charCodeAt(i);
  }
  return diff === 0;
}

async function createCodes(request, env) {
  const body = await request.json().catch(() => ({}));
  const count = Math.min(Math.max(parseInt(body.count ?? 1, 10) || 1, 1), 200);
  const maxUses = Math.min(Math.max(parseInt(body.maxUses ?? 1, 10) || 1, 1),
    10000);
  const note = String(body.note ?? '').slice(0, 200);
  const expiresAt = body.expiresAt ? parseInt(body.expiresAt, 10) : null;

  const now = Math.floor(Date.now() / 1000);
  const codes = Array.from({ length: count }, () => normalise(mintCode()));
  await env.DB.batch(codes.map((c) => env.DB.prepare(
    `INSERT INTO codes (code, note, max_uses, revoked, created_at, expires_at)
     VALUES (?1, ?2, ?3, 0, ?4, ?5)`).bind(c, note, maxUses, now, expiresAt)));

  return json({ codes: codes.map(grouped), maxUses, note });
}

async function listCodes(env) {
  const { results } = await env.DB.prepare(`
    SELECT c.code, c.note, c.max_uses, c.revoked, c.created_at, c.expires_at,
           (SELECT COUNT(*) FROM redemptions r WHERE r.code = c.code) AS uses
      FROM codes c
     ORDER BY c.created_at DESC
  `).all();
  return json({
    codes: results.map((r) => ({
      code: grouped(r.code),
      note: r.note,
      uses: r.uses,
      maxUses: r.max_uses,
      revoked: !!r.revoked,
      spent: r.uses >= r.max_uses,
      createdAt: r.created_at,
      expiresAt: r.expires_at,
    })),
  });
}

async function revokeCode(request, env) {
  const body = await request.json().catch(() => ({}));
  const code = normalise(body.code);
  const { meta } = await env.DB.prepare(
    'UPDATE codes SET revoked = 1 WHERE code = ?1').bind(code).run();
  // Revoking does not remove redemptions. Someone already unlocked holds a
  // signed token and keeps their access; this only stops further redemptions.
  return json({ revoked: meta.changes > 0 });
}

export default {
  async fetch(request, env) {
    const url = new URL(request.url);

    if (request.method === 'OPTIONS') {
      return new Response(null, { status: 204, headers: CORS });
    }
    if (url.pathname === '/health') {
      return json({ ok: true });
    }
    if (url.pathname === '/redeem' && request.method === 'POST') {
      return redeem(request, env);
    }

    if (url.pathname.startsWith('/admin/')) {
      if (!authorised(request, env)) return json({ error: 'forbidden' }, 403);
      if (url.pathname === '/admin/codes' && request.method === 'POST') {
        return createCodes(request, env);
      }
      if (url.pathname === '/admin/codes' && request.method === 'GET') {
        return listCodes(env);
      }
      if (url.pathname === '/admin/revoke' && request.method === 'POST') {
        return revokeCode(request, env);
      }
    }

    return json({ error: 'not_found' }, 404);
  },
};
