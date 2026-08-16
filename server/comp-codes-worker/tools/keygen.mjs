/**
 * Makes the Ed25519 key pair the Worker signs unlock tokens with.
 *
 *   node tools/keygen.mjs
 *
 * Prints two things. The private key goes into the Worker as a secret and
 * nowhere else. The public key is compiled into the app, and is public by
 * definition — committing it is the point, so the app can check a token
 * without asking anyone whether it is genuine.
 *
 * Run this once. Replacing the pair invalidates every token already issued,
 * so everyone who has redeemed a code would lose their unlock.
 */
import { webcrypto as crypto } from 'node:crypto';

const pair = await crypto.subtle.generateKey({ name: 'Ed25519' }, true,
  ['sign', 'verify']);

const pkcs8 = await crypto.subtle.exportKey('pkcs8', pair.privateKey);
const raw = await crypto.subtle.exportKey('raw', pair.publicKey);

const b64 = (b) => Buffer.from(b).toString('base64');

console.log('PRIVATE (Worker secret WREN_SIGNING_KEY — never commit):');
console.log(b64(pkcs8));
console.log();
console.log('PUBLIC (embed in the app, safe to commit):');
console.log(b64(raw));
