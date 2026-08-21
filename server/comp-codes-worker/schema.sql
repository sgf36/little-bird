-- Complimentary unlock codes for Wren.
--
-- There is deliberately no `uses` counter on `codes`. A counter is a second
-- source of truth that drifts the first time an increment succeeds and the
-- matching insert does not, and it turns "is this code spent?" into a question
-- with two possible answers. Usage is counted from `redemptions`, which is the
-- only place a redemption is recorded, so the two cannot disagree.

CREATE TABLE IF NOT EXISTS codes (
  code        TEXT    PRIMARY KEY,
  note        TEXT,                                  -- who it went to
  max_uses    INTEGER NOT NULL DEFAULT 1,
  revoked     INTEGER NOT NULL DEFAULT 0,
  created_at  INTEGER NOT NULL,
  expires_at  INTEGER,                               -- NULL means never
  -- What the code grants. 'unlock' is the paid feature and nothing else;
  -- 'admin' is that plus the ability to issue and withdraw codes from inside
  -- the app. Defaulted, so every code that existed before this column did is
  -- an ordinary unlock rather than silently becoming an administrator.
  --
  -- This column, not the `r` claim in the token, is what decides whether an
  -- administrative request is allowed. The token says what the app should
  -- show; the table says what the server will do. Keeping the decision here
  -- is what makes revoking an administrator take effect immediately, on a
  -- device that is already holding a valid signed token.
  role        TEXT    NOT NULL DEFAULT 'unlock'
      CHECK (role IN ('unlock', 'admin'))
);

-- One row per (code, device). The primary key is what makes redeeming
-- idempotent: a friend who reinstalls and re-enters their code conflicts with
-- their own earlier row rather than spending a second use.
CREATE TABLE IF NOT EXISTS redemptions (
  code        TEXT    NOT NULL,
  device      TEXT    NOT NULL,
  redeemed_at INTEGER NOT NULL,
  PRIMARY KEY (code, device)
);

CREATE INDEX IF NOT EXISTS redemptions_by_code ON redemptions (code);

-- Failed attempts, for rate limiting. Codes are 78 bits of entropy so guessing
-- is not a real threat, but an unbounded endpoint that answers yes or no is
-- still worth a lid.
CREATE TABLE IF NOT EXISTS attempts (
  ip TEXT    NOT NULL,
  at INTEGER NOT NULL
);

CREATE INDEX IF NOT EXISTS attempts_by_ip_at ON attempts (ip, at);
