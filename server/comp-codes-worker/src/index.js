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
 *
 * A code carries a role. 'unlock' is the paid feature and nothing more, which
 * is what every code was before roles existed. 'admin' is that plus the right
 * to issue and withdraw codes — so the person who runs Wren can hand out an
 * unlock from a phone instead of a terminal, and so nobody else can, because
 * the app shows no trace of it without an administrator's token.
 *
 * The token an administrator holds is a bearer credential for /admin/*, but it
 * is not the whole of the decision: every administrative request re-reads the
 * code's role from D1. That is deliberate. Unlock entitlements are checked
 * offline forever, so withdrawing one is impossible; withdrawing an
 * administrator has to be possible, and it is, because the table is consulted
 * rather than the signature alone.
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
 *
 * `r` is the role. The app reads it to decide whether to offer the code
 * console at all; the server does not trust it for that, and re-reads the role
 * from the table on every administrative request. A token minted before roles
 * existed carries no `r` and is read as an ordinary unlock.
 */
async function issueToken(env, device, code, role) {
  const payload = JSON.stringify({
    v: 1,
    d: device,
    c: code,
    r: role,
    t: Math.floor(Date.now() / 1000),
  });
  const body = new TextEncoder().encode(payload);
  const sig = await crypto.subtle.sign({ name: 'Ed25519' },
    await signingKey(env), body);
  return `${b64url(body)}.${b64url(sig)}`;
}

/**
 * The fixed twelve bytes that turn a bare 32-byte Ed25519 public key into the
 * SPKI DER every WebCrypto implementation will import. `raw` is accepted for
 * Ed25519 public keys in some runtimes and not others, and a key format that
 * works on Workers but not under `node --test` is a verification path with no
 * test covering it.
 */
const SPKI_ED25519_PREFIX = Uint8Array.from([
  0x30, 0x2a, 0x30, 0x05, 0x06, 0x03, 0x2b, 0x65, 0x70, 0x03, 0x21, 0x00,
]);

const fromB64 = (s) => Uint8Array.from(atob(s), (c) => c.charCodeAt(0));

const fromB64Url = (s) =>
  fromB64(s.replace(/-/g, '+').replace(/_/g, '/').padEnd(
    s.length + ((4 - (s.length % 4)) % 4), '='));

async function verifyingKey(env) {
  const raw = fromB64(env.WREN_PUBLIC_KEY);
  const spki = new Uint8Array(SPKI_ED25519_PREFIX.length + raw.length);
  spki.set(SPKI_ED25519_PREFIX);
  spki.set(raw, SPKI_ED25519_PREFIX.length);
  return crypto.subtle.importKey('spki', spki, { name: 'Ed25519' }, false,
    ['verify']);
}

/**
 * The claims inside a token this Worker signed, or null for anything else.
 *
 * Verified rather than merely parsed: without the signature check, `c` and `d`
 * are two strings an attacker chooses, and the D1 lookup that follows would be
 * asking whether a code they invented exists rather than whether the token
 * they hold is genuine.
 */
export async function verifiedClaims(env, token) {
  const parts = String(token || '').split('.');
  if (parts.length !== 2) return null;
  try {
    const payload = fromB64Url(parts[0]);
    const ok = await crypto.subtle.verify({ name: 'Ed25519' },
      await verifyingKey(env), fromB64Url(parts[1]), payload);
    if (!ok) return null;
    return JSON.parse(new TextDecoder().decode(payload));
  } catch {
    return null;
  }
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

  // The role is read back from the row that was just written rather than from
  // a separate lookup, so a code cannot be minted as an unlock and answered as
  // an administrator by two statements racing each other.
  const held = await env.DB.prepare(`
    SELECT c.role AS role FROM redemptions r
      JOIN codes c ON c.code = r.code
     WHERE r.code = ?1 AND r.device = ?2`)
    .bind(code, device).first();

  if (!held) {
    await recordFailure(env, ip);
    // Deliberately one reason for every refusal. Telling a stranger that a
    // code is real but spent confirms the code is real.
    return json({ error: 'invalid_code' }, 403);
  }

  const role = held.role === 'admin' ? 'admin' : 'unlock';
  return json({ token: await issueToken(env, device, code, role), role });
}

/**
 * Re-issues a token that is still good, so that withdrawing a code reaches a
 * device which has already redeemed it.
 *
 * An unlock is otherwise permanent: it is a signature checked on the phone,
 * and nothing here is consulted again. That is right for a code given to a
 * friend and wrong for one that also opens the code console, so the app treats
 * an admin token as good for a fortnight and asks for a fresh one daily.
 *
 * Renewal rather than an "is this still live?" answer, deliberately. A boolean
 * can be forged in the deny direction by anything sitting on the network, and
 * suppressed in the allow direction by unplugging. A token cannot be forged at
 * all, so a fake server can neither grant nor withdraw: the worst it manages is
 * silence, and silence is already the same as refusal once the fortnight runs
 * out. Blocking the network to dodge a withdrawal and simply being withdrawn
 * therefore end in the same place, with no code deciding which is which.
 *
 * Reads the redemption row and never writes one, so renewing does not spend a
 * use — which would otherwise burn through the App Review code in under a week.
 */
export async function renew(request, env) {
  let body;
  try {
    body = await request.json();
  } catch {
    return json({ error: 'bad_request' }, 400);
  }

  const claims = await verifiedClaims(env, body.token);
  // One reason for every refusal, as with redeeming. A device being told
  // whether its code was withdrawn or merely expired is of no use to it and
  // tells anyone holding a stolen token which it is.
  if (!claims) return json({ error: 'not_live' }, 403);

  const code = normalise(claims.c);
  const device = String(claims.d ?? '');
  if (!code || !device) return json({ error: 'not_live' }, 403);

  const row = await env.DB.prepare(`
    SELECT c.role AS role FROM redemptions r
      JOIN codes c ON c.code = r.code
     WHERE r.code = ?1 AND r.device = ?2
       AND c.revoked = 0
       AND (c.expires_at IS NULL OR c.expires_at > ?3)`)
    .bind(code, device, Math.floor(Date.now() / 1000)).first();
  if (!row) return json({ error: 'not_live' }, 403);

  const role = row.role === 'admin' ? 'admin' : 'unlock';
  return json({ token: await issueToken(env, device, code, role), role });
}

function isOperator(given, env) {
  const want = env.ADMIN_TOKEN ?? '';
  if (!want || given.length !== want.length) return false;
  let diff = 0;
  for (let i = 0; i < want.length; i++) {
    diff |= given.charCodeAt(i) ^ want.charCodeAt(i);
  }
  return diff === 0;
}

/**
 * An administrator holding a redeemed admin code, or null.
 *
 * Two things have to hold, and the second is the one that matters. The token
 * must verify against the signing pair, so it cannot be written by hand; and
 * the code it names must still be an admin code, still be live, and still have
 * been redeemed by this device — read now, not when the token was issued.
 *
 * That second half is why revoking an administrator works. An unlock is
 * checked offline and can never be taken back; this is checked here, so a
 * revoked administrator loses the console on their next request while keeping
 * the unlock they were also granted.
 */
async function adminByDeviceToken(env, token) {
  const claims = await verifiedClaims(env, token);
  if (!claims) return null;
  const code = normalise(claims.c);
  const device = String(claims.d ?? '');
  if (!code || !device) return null;
  const row = await env.DB.prepare(`
    SELECT 1 FROM redemptions r
      JOIN codes c ON c.code = r.code
     WHERE r.code = ?1 AND r.device = ?2
       AND c.role = 'admin'
       AND c.revoked = 0
       AND (c.expires_at IS NULL OR c.expires_at > ?3)`)
    .bind(code, device, Math.floor(Date.now() / 1000)).first();
  return row ? { via: 'device', code, device } : null;
}

/**
 * Who is asking, or null.
 *
 * Two kinds of caller present a bearer token: the operator's shared
 * `ADMIN_TOKEN`, which is how codes have always been issued from a terminal,
 * and a phone holding a redeemed admin code. One header serves both, so an app
 * and a curl command make the same request.
 *
 * The shared token is tried first, and the device path is reached only if that
 * fails. Ordering it the other way — dispatching on the dot in
 * `payload.signature` — would have locked the operator out for good the day
 * their token happened to contain a full stop, and rotating a credential is
 * not a moment to discover a new rule about which characters it may hold.
 */
async function authorise(request, env) {
  const header = request.headers.get('Authorization') ?? '';
  const given = header.replace(/^Bearer\s+/i, '');
  if (!given) return null;
  if (isOperator(given, env)) return { via: 'operator' };
  // Only a signed token can be anything else, and a signed token has a dot.
  // Cheap enough to skip a D1 read and a signature check on obvious rubbish.
  return given.includes('.') ? adminByDeviceToken(env, given) : null;
}

async function createCodes(request, env) {
  const body = await request.json().catch(() => ({}));
  const count = Math.min(Math.max(parseInt(body.count ?? 1, 10) || 1, 1), 200);
  const maxUses = Math.min(Math.max(parseInt(body.maxUses ?? 1, 10) || 1, 1),
    10000);
  const note = String(body.note ?? '').slice(0, 200);
  const expiresAt = body.expiresAt ? parseInt(body.expiresAt, 10) : null;

  // Anything unrecognised is an unlock. Defaulting the other way would turn a
  // typo, or an older client that does not send the field, into an
  // administrator. The column carries the same CHECK on a fresh database, but
  // it cannot be added to the existing one without rebuilding the table, so
  // this is where the values are actually held to two.
  const role = body.role === 'admin' ? 'admin' : 'unlock';

  const now = Math.floor(Date.now() / 1000);
  const codes = Array.from({ length: count }, () => normalise(mintCode()));
  await env.DB.batch(codes.map((c) => env.DB.prepare(
    `INSERT INTO codes
       (code, note, max_uses, revoked, created_at, expires_at, role)
     VALUES (?1, ?2, ?3, 0, ?4, ?5, ?6)`)
    .bind(c, note, maxUses, now, expiresAt, role)));

  return json({ codes: codes.map(grouped), maxUses, note, role });
}

async function listCodes(env) {
  const { results } = await env.DB.prepare(`
    SELECT c.code, c.note, c.max_uses, c.revoked, c.created_at, c.expires_at,
           c.role,
           (SELECT COUNT(*) FROM redemptions r WHERE r.code = c.code) AS uses
      FROM codes c
     ORDER BY c.created_at DESC
  `).all();
  return json({
    codes: results.map((r) => ({
      code: grouped(r.code),
      note: r.note,
      role: r.role ?? 'unlock',
      uses: r.uses,
      maxUses: r.max_uses,
      revoked: !!r.revoked,
      spent: r.uses >= r.max_uses,
      createdAt: r.created_at,
      expiresAt: r.expires_at,
    })),
  });
}

async function revokeCode(request, env, caller) {
  const body = await request.json().catch(() => ({}));
  const code = normalise(body.code);
  // An administrator revoking the code they are holding would sign themselves
  // out mid-sentence, and the console would then be unreachable from that
  // phone with nothing on screen explaining why. The operator's shared token
  // can still do it from a terminal, where the consequence is visible.
  if (caller?.via === 'device' && caller.code === code) {
    return json({ error: 'would_revoke_self' }, 409);
  }
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
    if (url.pathname === '/renew' && request.method === 'POST') {
      return renew(request, env);
    }

    if (url.pathname.startsWith('/admin/')) {
      const caller = await authorise(request, env);
      if (!caller) return json({ error: 'forbidden' }, 403);
      if (url.pathname === '/admin/codes' && request.method === 'POST') {
        return createCodes(request, env);
      }
      if (url.pathname === '/admin/codes' && request.method === 'GET') {
        return listCodes(env);
      }
      if (url.pathname === '/admin/revoke' && request.method === 'POST') {
        return revokeCode(request, env, caller);
      }
    }

    return json({ error: 'not_found' }, 404);
  },
};
