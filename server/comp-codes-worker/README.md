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

    # who has used what
    curl https://wren-codes.sgf36.workers.dev/admin/codes -H "Authorization: Bearer $env:T"

    # stop a code working (already-redeemed devices keep their access)
    curl -X POST https://wren-codes.sgf36.workers.dev/admin/revoke `
      -H "Authorization: Bearer $env:T" -H "Content-Type: application/json" `
      -d '{"code":"XXXX-XXXX-XXXX-XXXX"}'

**The App Review code is not single use.** Review may test across several
resubmissions, and a reviewer who finds a spent code is a rejection. It is
issued with a high `maxUses` and noted as such. Because it lives here rather
than in the build, it can be rotated in seconds without a release — which the
previous `--dart-define` version could not.

## Redeeming, from the app

`POST /redeem` with `{"code": "...", "device": "..."}`.

- `200 {"token": "..."}` — accepted
- `403` — wrong, spent, revoked or expired; deliberately indistinguishable
- `429` — too many failures from this address
