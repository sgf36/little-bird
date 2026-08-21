# Complimentary unlock codes

Gives a named person — a friend, a tester, App Review — Wren's paid feature
without a payment, using a code that works once and then does not.

Live at `https://wren-codes.sgf36.workers.dev`.

## Why this exists rather than nothing

The app has no other server, and the App Store listing says so. This is the one
exception, and it is here because single use cannot be decided on a phone.

A code could be signed and checked offline against a public key compiled into
the app: no server, no network, unlimited codes. But nothing on a device can
know that a code has already been spent on a different device, so one code
pasted into a group chat would unlock the app for everyone who read it.
"Already redeemed" is a fact with exactly one home.

## Why not Apple's promo codes

Apple gives 100 single-use promo codes per version for a non-consumable
purchase, redeemed through the App Store, and they are the better answer once
the app is live: no server, no privacy wording to justify, and the unlock
arrives as a real StoreKit transaction that restores across devices by itself.

They also expire 28 days after generation, are capped at 100 per version, and
need the app to be on sale. This works before launch, does not expire, and is
reachable from inside the app.

## Two kinds of code

A code carries a **role**.

- `unlock` — the paid feature, and nothing else. Every code was this before
  roles existed, and every code issued before the `role` column was added still
  is.
- `admin` — the same unlock, plus the right to issue and withdraw codes from
  inside the app. Wren shows no sign of this to anyone else: the long press on
  the app name opens the code box as it always has, and opens the console only
  on a device that has redeemed an admin code.

An admin code is a real transfer of authority — whoever holds one can give the
paid feature away, and can issue further admin codes. Issue them by name and to
people, not to roles.

### Withdrawing an administrator actually works

An unlock cannot be taken back. It is a signed token on somebody's phone,
checked offline, and by design nothing here is consulted again.

The console is the opposite: every `/admin/*` request re-reads the code's role
from the `codes` table. So revoking an admin code takes the console away on the
next request — while leaving the unlock it also granted, which is unreachable.

### Migrating

`schema.sql` uses `CREATE TABLE IF NOT EXISTS`, so re-running it against the
live database does **not** add the column. Run the migration first, then deploy:

    npx wrangler d1 execute wren-codes --remote       --command "ALTER TABLE codes ADD COLUMN role TEXT NOT NULL DEFAULT 'unlock';"
    npx wrangler deploy

`--command`, not `--file`. `--file` uploads through D1's import endpoint,
which refuses this account's Wrangler OAuth token with "Authentication error
[code: 10000]" even though `wrangler whoami` shows d1 (write) and Super
Administrator — the query endpoint accepts the very same token. It reads as a
permissions problem, is not one, and logging in again does not help. The
migration is one statement, so `--command` loses nothing; a longer one would
need `CLOUDFLARE_API_TOKEN` set to a real API token instead.

Deploying without it makes every redemption fail with `no such column: role`,
which from the app looks exactly like a code that was never issued.

## Shape

- **D1**, not KV. Redeeming has to be atomic, and KV has no transactions.
- **No `uses` counter.** Usage is counted from the `redemptions` table, so
  there is no second number to drift out of step with the first.
- **One statement decides everything.** The insert only writes a row if the
  code exists, is live, and has spare uses; `ON CONFLICT DO NOTHING` makes a
  repeat from the same device a no-op rather than a second use. Checking and
  then writing would let two simultaneous redemptions of a one-use code both
  pass the check — there is a test for exactly this.
- **The device id is a random UUID in the iOS keychain**, not
  `identifierForVendor`, which resets when the last app from a vendor is
  removed. The keychain survives app deletion, so a friend who reinstalls and
  re-enters their code is recognised as the same redemption instead of being
  refused by their own earlier one.
- **Every refusal gives the same reason.** Telling a stranger that a code is
  real but spent confirms that the code is real.

## Tokens

A successful redemption returns `payload.signature`, base64url, signed Ed25519.
The payload names the device, so a token lifted off one phone is worthless on
another. The app verifies it against a public key compiled in, and stores it.

Two things follow. The app checks its own entitlement offline from then on and
never phones home at launch; and pointing the app at a look-alike server gains
nothing, because a forged "yes" cannot carry a valid signature.

The public key is in `lib/src/comp_unlock.dart` and is meant to be there.
Replacing the key pair invalidates every token already issued, so everyone who
has redeemed would silently lose their unlock — generate it once.

## Who may call /admin/*

Two callers, one header, so a phone and a curl command make the same request.

- **The operator's `ADMIN_TOKEN`** — tried first, compared in constant time.
  Unchanged, and still the only way to withdraw the code a phone is using.
- **A device holding an admin code** — the very token it was issued when it
  redeemed. The signature is verified against `WREN_PUBLIC_KEY`, and then the
  code it names is looked up: it must still be an admin code, still be live,
  and still have been redeemed by that device.

The order matters. Dispatching on the dot in `payload.signature` instead would
lock the operator out the day their token happened to contain a full stop.

The `r` claim in the token is *not* what authorises anything. It tells the app
whether to offer the console; the table decides what the server will do. That
split is what makes an administrator revocable.

`WREN_PUBLIC_KEY` is a var in `wrangler.toml`, not a secret — it is the same
value compiled into the app, it can verify a signature but never make one, and
a test asserts the two copies match.

## Secrets

    wrangler secret put WREN_SIGNING_KEY   # base64 pkcs8, from tools/keygen.mjs
    wrangler secret put ADMIN_TOKEN        # guards /admin/*

`wrangler secret put` takes the secret's **name**. The value goes at the
interactive prompt, or on stdin. Passing the value as the argument creates a
secret whose name is the credential, leaves the real one unset, and writes the
credential into Wrangler's logs. `wrangler secret list` should show exactly
`ADMIN_TOKEN` and `WREN_SIGNING_KEY` and nothing that looks like a password.

The admin token is in Windows Credential Manager under service
`wren-comp-codes`, account `admin`.

## Issuing codes

    $env:T = python -c "import keyring;print(keyring.get_password('wren-comp-codes','admin'))"

    # five one-use codes for friends
    curl -X POST https://wren-codes.sgf36.workers.dev/admin/codes `
      -H "Authorization: Bearer $env:T" -H "Content-Type: application/json" `
      -d '{"count":5,"note":"friends","maxUses":1}'

    # one code that can issue further codes from inside the app
    curl -X POST https://wren-codes.sgf36.workers.dev/admin/codes `
      -H "Authorization: Bearer $env:T" -H "Content-Type: application/json" `
      -d '{"count":1,"note":"me","maxUses":1,"role":"admin"}'

`role` is omitted for an ordinary unlock. Anything the server does not
recognise is an unlock too — defaulting the other way would make a typo an
administrator.

    # who has used what
    curl https://wren-codes.sgf36.workers.dev/admin/codes -H "Authorization: Bearer $env:T"

    # stop a code working (already-redeemed devices keep their access)
    curl -X POST https://wren-codes.sgf36.workers.dev/admin/revoke `
      -H "Authorization: Bearer $env:T" -H "Content-Type: application/json" `
      -d '{"code":"XXXX-XXXX-XXXX-XXXX"}'

### If a probe gets 403 and you are sure the token is right

Check `/health` first. It answers `{"ok":true}` to anyone, so a 403 there is
not this Worker refusing you — it is Cloudflare's edge refusing the *client*,
and the body says `error code: 1010` rather than `{"error":"forbidden"}`. A
default `python-urllib`, `python-requests` or `curl` user agent is enough to
trigger it. Send an ordinary `User-Agent` and it goes away. The two 403s are
otherwise indistinguishable, and the wrong one reads as a revoked credential.

**The App Review code is not single use.** Review may test across several
resubmissions, and a reviewer who finds a spent code is a rejection. It is
issued with a high `maxUses` and noted as such. Because it lives here rather
than in the build, it can be rotated in seconds without a release — which the
previous `--dart-define` version could not.

## Redeeming, from the app

`POST /redeem` with `{"code": "...", "device": "..."}`.

- `200 {"token": "...", "role": "unlock"|"admin"}` — accepted. The role is
  also inside the signed token, and only that copy counts: the app reads it
  from the signature, and the server re-reads it from the table.
- `403` — wrong, spent, revoked or expired; deliberately indistinguishable
- `429` — too many failures from this address
