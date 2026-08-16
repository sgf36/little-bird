"""Deploy web/ to littlebird.spencerfields.com via the cPanel API.

No browser, no login — the API token lives in Windows Credential Manager under
service `cpanel-littlebird-site` (falling back to the EasyPost token, which is
the same cPanel account), or in CPANEL_API_TOKEN.

Three traps on this host, all of which mimic other faults:
  1. UAPI answers HTTP 200 even when the call failed. Check the JSON `status`.
  2. Responses carry no charset header, so requests guesses latin-1 and the
     output looks like mojibake that is not actually there. Decode as UTF-8.
  3. mod_security returns 406 to a python-requests User-Agent.

Usage:  python web/deploy.py [file ...]      (default: everything in web/)
"""
import json, os, sys, pathlib, keyring, requests

HOST = "box5192.bluehost.com"
PORT = 2083
USER = "spencgh6"
DOCROOT = f"/home2/{USER}/wren.spencerfields.com"
WEB = pathlib.Path(__file__).parent

def token():
    t = os.environ.get("CPANEL_API_TOKEN")
    for service in ("cpanel-littlebird-site", "cpanel-easypost-site"):
        if t:
            break
        t = keyring.get_password(service, USER)
    if not t:
        sys.exit("no cPanel token: set CPANEL_API_TOKEN or add it to Credential Manager")
    return t

S = requests.Session()
S.headers.update({
    "Authorization": f"cpanel {USER}:{token()}",
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
                  "(KHTML, like Gecko) Chrome/128.0 Safari/537.36",
})

def check(resp):
    resp.encoding = "utf-8"
    try:
        data = json.loads(resp.text)
    except ValueError:
        sys.exit(f"non-JSON reply (HTTP {resp.status_code}): {resp.text[:300]}")
    if not data.get("status"):
        sys.exit(f"cPanel refused: {data.get('errors') or data}")
    return data.get("data")

def upload(path: pathlib.Path):
    with path.open("rb") as fh:
        r = S.post(
            f"https://{HOST}:{PORT}/execute/Fileman/upload_files",
            data={"dir": DOCROOT, "overwrite": 1},
            files={"file-1": (path.name, fh, "application/octet-stream")},
            timeout=120,
        )
    result = check(r)
    # upload_files reports per-file success separately from the envelope status.
    for entry in (result.get("uploads") or []):
        if not entry.get("status"):
            sys.exit(f"{path.name} rejected: {entry.get('reason')}")
    return path.stat().st_size

targets = [pathlib.Path(a) for a in sys.argv[1:]] or \
          sorted(p for p in WEB.iterdir() if p.is_file() and p.suffix in {".html", ".css", ".js", ".php", ".svg", ".png", ".ico", ".txt", ".xml"})

if not targets:
    sys.exit("nothing to upload")

for p in targets:
    size = upload(p)
    print(f"uploaded {p.name}  ({size:,} bytes)")

print(f"\ndeployed to {DOCROOT}")
print("verify at https://wren.spencerfields.com/ — a 200 from the API is")
print("not proof the page is live, so always fetch it back.")
