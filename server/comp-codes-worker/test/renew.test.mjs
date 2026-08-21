/**
 * Renewal is what makes withdrawing a code reach a phone that already redeemed
 * it. Three things have to hold and each fails silently on its own:
 *
 * - a live administrator gets a fresh token, or their access lapses in a
 *   fortnight for no reason;
 * - a withdrawn one gets nothing, or withdrawal never bites at all;
 * - renewing reads the redemption and never writes one, or the App Review code
 *   spends its five hundred uses in under a week of daily renewals.
 *
 * D1 is stubbed rather than mocked in detail: what matters is whether a row
 * came back, and the SQL that decides is the same statement as `/redeem`'s,
 * which is exercised against the deployed Worker.
 */
import { test } from 'node:test';
import assert from 'node:assert/strict';
import { renew, verifiedClaims } from '../src/index.js';

const b64 = (bytes) => Buffer.from(bytes).toString('base64');
const b64url = (bytes) =>
  Buffer.from(bytes).toString('base64url').replace(/=+$/, '');

/** An `env` holding a signing pair, and a D1 that answers with `row`. */
async function envWith(row) {
  const keys = await crypto.subtle.generateKey({ name: 'Ed25519' }, true,
    ['sign', 'verify']);
  const statements = [];
  return {
    keys,
    statements,
    env: {
      WREN_PUBLIC_KEY: b64(await crypto.subtle.exportKey('raw', keys.publicKey)),
      WREN_SIGNING_KEY:
        b64(await crypto.subtle.exportKey('pkcs8', keys.privateKey)),
      DB: {
        prepare(sql) {
          statements.push(sql);
          return { bind: () => ({ first: async () => row }) };
        },
      },
    },
  };
}

async function token(keys, claims) {
  const body = new TextEncoder().encode(JSON.stringify(claims));
  const sig = await crypto.subtle.sign({ name: 'Ed25519' }, keys.privateKey,
    body);
  return `${b64url(body)}.${b64url(sig)}`;
}

const post = (body) =>
  new Request('https://example.invalid/renew', {
    method: 'POST',
    body: JSON.stringify(body),
  });

const held = { v: 1, d: 'device-A', c: 'ABCDEFGHJKMNPQRS', r: 'admin', t: 1 };

test('a live administrator gets a fresh token naming the same device', async () => {
  const { keys, env } = await envWith({ role: 'admin' });
  const response = await renew(post({ token: await token(keys, held) }), env);
  assert.equal(response.status, 200);

  const { token: fresh, role } = await response.json();
  assert.equal(role, 'admin');
  const claims = await verifiedClaims(env, fresh);
  assert.ok(claims, 'the reissued token does not verify');
  assert.equal(claims.d, 'device-A');
  assert.equal(claims.c, 'ABCDEFGHJKMNPQRS');
  assert.equal(claims.r, 'admin');
  assert.ok(claims.t > held.t, 'the clock was not reset, so it will lapse');
});

test('renewing reads a redemption and never writes one', async () => {
  // A renewal that spent a use would burn the App Review code, whose whole
  // point is surviving repeated submissions.
  const { keys, env, statements } = await envWith({ role: 'admin' });
  await renew(post({ token: await token(keys, held) }), env);
  for (const sql of statements) {
    assert.doesNotMatch(sql, /\b(INSERT|UPDATE|DELETE)\b/i,
      `renewal wrote to the database: ${sql}`);
  }
});

test('a withdrawn code is refused, which is what makes it a withdrawal',
  async () => {
    // No row: the SQL requires revoked = 0, an unexpired code and a redemption
    // by this device, so any of those failing lands here.
    const { keys, env } = await envWith(null);
    const response = await renew(post({ token: await token(keys, held) }), env);
    assert.equal(response.status, 403);
    assert.deepEqual(await response.json(), { error: 'not_live' });
  });

test('an ordinary unlock renews as an unlock, never promoted', async () => {
  const { keys, env } = await envWith({ role: 'unlock' });
  const response = await renew(
    post({ token: await token(keys, { ...held, r: 'unlock' }) }), env);
  const { token: fresh } = await response.json();
  assert.equal((await verifiedClaims(env, fresh)).r, 'unlock');
});

test('the role comes from the table, not from the token', async () => {
  // A token claiming admin against a row that says unlock renews as an unlock.
  // The claim is what the app reads; the table is what is true.
  const { keys, env } = await envWith({ role: 'unlock' });
  const response = await renew(post({ token: await token(keys, held) }), env);
  const { token: fresh, role } = await response.json();
  assert.equal(role, 'unlock');
  assert.equal((await verifiedClaims(env, fresh)).r, 'unlock');
});

test('a forged token is refused before the database is consulted', async () => {
  const { env, statements } = await envWith({ role: 'admin' });
  const other = await envWith(null);
  const forged = await token(other.keys, held);
  const response = await renew(post({ token: forged }), env);
  assert.equal(response.status, 403);
  assert.deepEqual(statements, [], 'a forgery reached the database');
});

test('rubbish is refused rather than throwing', async () => {
  const { env } = await envWith({ role: 'admin' });
  for (const body of [{}, { token: '' }, { token: 'nonsense' },
    { token: 'a.b' }]) {
    const response = await renew(post(body), env);
    assert.equal(response.status, 403, JSON.stringify(body));
  }
  const bad = new Request('https://example.invalid/renew',
    { method: 'POST', body: 'not json' });
  assert.equal((await renew(bad, env)).status, 400);
});
