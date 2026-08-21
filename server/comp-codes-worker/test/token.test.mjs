/**
 * The half of the administrator path that can be tested without deploying.
 *
 * Issuing and withdrawing codes from inside the app rests on the Worker being
 * able to *verify* a token it once signed. Every other check — that the code
 * is an admin code, that it is live, that this device redeemed it — is a D1
 * lookup that only runs once verification passes, so a verifier that says yes
 * to anything would make all of them decorative, and one that says no to
 * everything would lock the console shut with a 403 that reads exactly like a
 * revoked code.
 *
 * The signing half is a Worker-only API surface (`Ed25519` in WebCrypto), and
 * Node implements the same one, so a token is minted here the way the Worker
 * mints one and handed to the Worker's own verifier.
 */
import { test } from 'node:test';
import assert from 'node:assert/strict';
import { verifiedClaims } from '../src/index.js';

const b64 = (bytes) => Buffer.from(bytes).toString('base64');
const b64url = (bytes) =>
  Buffer.from(bytes).toString('base64url').replace(/=+$/, '');

/** A signing pair, and the `env` the Worker would see holding its public half. */
async function pair() {
  const keys = await crypto.subtle.generateKey({ name: 'Ed25519' }, true,
    ['sign', 'verify']);
  const raw = await crypto.subtle.exportKey('raw', keys.publicKey);
  return { keys, env: { WREN_PUBLIC_KEY: b64(raw) } };
}

/** A token exactly as `issueToken` builds one. */
async function token(keys, claims) {
  const body = new TextEncoder().encode(JSON.stringify(claims));
  const sig = await crypto.subtle.sign({ name: 'Ed25519' }, keys.privateKey,
    body);
  return `${b64url(body)}.${b64url(sig)}`;
}

test('a token this Worker signed reads back as its own claims', async () => {
  const { keys, env } = await pair();
  const claims = { v: 1, d: 'device-A', c: 'ABCDEFGHJKMNPQRS', r: 'admin', t: 1 };
  assert.deepEqual(await verifiedClaims(env, await token(keys, claims)), claims);
});

test('a token signed by anything else is refused', async () => {
  // The point of verifying rather than parsing: without this, `c` and `d` are
  // two strings the caller picks, and the D1 lookup behind them is asking
  // whether an invented code exists rather than whether this token is real.
  const { env } = await pair();
  const other = await pair();
  const forged = await token(other.keys,
    { v: 1, d: 'device-A', c: 'ABCDEFGHJKMNPQRS', r: 'admin', t: 1 });
  assert.equal(await verifiedClaims(env, forged), null);
});

test('claims edited after signing are refused', async () => {
  const { keys, env } = await pair();
  const good = await token(keys,
    { v: 1, d: 'device-A', c: 'ABCDEFGHJKMNPQRS', r: 'unlock', t: 1 });
  const [, signature] = good.split('.');
  const promoted = b64url(new TextEncoder().encode(JSON.stringify(
    { v: 1, d: 'device-A', c: 'ABCDEFGHJKMNPQRS', r: 'admin', t: 1 })));
  assert.equal(await verifiedClaims(env, `${promoted}.${signature}`), null);
});

test('rubbish in place of a token is null rather than a throw', async () => {
  const { env } = await pair();
  for (const bad of ['', 'nonsense', 'a.b', 'a.b.c', null, undefined,
    '!!!!.!!!!']) {
    assert.equal(await verifiedClaims(env, bad), null, `accepted ${bad}`);
  }
});

test('the deployed public key is the one the app carries', async () => {
  // wrangler.toml and lib/src/comp_unlock.dart hold the same 32 bytes. If they
  // ever drift, redeeming still works — the app verifies with its own copy —
  // and only the console breaks, with a 403 indistinguishable from a revoked
  // code.
  const { readFileSync } = await import('node:fs');
  const url = (p) => new URL(p, import.meta.url);
  const inToml = readFileSync(url('../wrangler.toml'), 'utf8')
    .match(/WREN_PUBLIC_KEY\s*=\s*"([^"]+)"/)?.[1];
  const inApp = readFileSync(url('../../../lib/src/comp_unlock.dart'), 'utf8')
    .match(/_publicKeyBase64\s*=\s*'([^']+)'/)?.[1];
  assert.ok(inToml, 'wrangler.toml has no WREN_PUBLIC_KEY');
  assert.equal(inToml, inApp);
});
