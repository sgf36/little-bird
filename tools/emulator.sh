#!/usr/bin/env bash
# Launch an Android emulator that behaves like a machine you can actually use.
#
#     tools/emulator.sh [avd-name]        # default: wren_play
#
# Three things do not work out of the box, and none of them announces itself —
# you just find yourself unable to type, or a paste silently doing nothing:
#
#   1. hw.keyboard defaults to "no" on the Pixel device profiles, so the HOST
#      keyboard is ignored and only the on-screen keyboard responds. Typing
#      appears to do nothing at all.
#   2. hw.gpu.enabled defaults to "no" when an AVD is created from the command
#      line, which means software rendering: watchable, but sluggish enough to
#      make a demo painful.
#   3. Clipboard sharing is an emulator-wide UI setting, not a per-AVD one, and
#      on Windows it lives in the REGISTRY rather than any file:
#      HKCU\Software\Android Open Source Project\Emulator\set\clipboardSharing
#
# The mouse needs nothing — clicking in the window works, and the scroll wheel
# is governed by disableMouseWheel in the same registry key.
#
# Idempotent. Run it every time; it fixes whatever has drifted and launches.
set -euo pipefail

AVD="${1:-wren_play}"
SDK="${ANDROID_HOME:-/c/Users/$USER/AppData/Local/Android/Sdk}"
SDK="${SDK//\//}"
EMU="$SDK/emulator/emulator.exe"
ADB="$SDK/platform-tools/adb.exe"
CONFIG="$HOME/.android/avd/$AVD.avd/config.ini"

[ -x "$EMU" ] || { echo "no emulator at $EMU"; exit 1; }
[ -f "$CONFIG" ] || { echo "no AVD called $AVD (looked for $CONFIG)"; exit 1; }

# 1 + 2: per-AVD hardware. Written with no spaces around '=', which is how
# avdmanager writes this file — a sed expecting spaces silently matches nothing.
ensure() {
  local key="$1" want="$2"
  if grep -qE "^${key}=" "$CONFIG"; then
    sed -i -E "s|^${key}=.*|${key}=${want}|" "$CONFIG"
  else
    printf '%s=%s\n' "$key" "$want" >> "$CONFIG"
  fi
}
ensure "hw.keyboard" "yes"
ensure "hw.gpu.enabled" "yes"
ensure "hw.gpu.mode" "auto"

# 3: clipboard sharing, emulator-wide, in the registry on Windows.
if command -v powershell.exe >/dev/null 2>&1; then
  powershell.exe -NoProfile -Command '
    $k = "HKCU:\Software\Android Open Source Project\Emulator\set"
    if (-not (Test-Path $k)) { New-Item -Path $k -Force | Out-Null }
    Set-ItemProperty -Path $k -Name clipboardSharing -Value "true"
    Set-ItemProperty -Path $k -Name disableMouseWheel -Value "false"
  ' >/dev/null 2>&1 || echo "! could not set clipboard sharing in the registry"
fi

echo "$AVD: keyboard on, GPU on, clipboard sharing on"
"$ADB" start-server >/dev/null 2>&1 || true
("$EMU" -avd "$AVD" -no-snapshot-load -gpu auto >/tmp/emulator-$AVD.log 2>&1 &)

printf 'booting'
for _ in $(seq 1 60); do
  if [ "$("$ADB" shell getprop sys.boot_completed 2>/dev/null | tr -d '\r')" = "1" ]; then
    echo; echo "booted. window is on the desktop."
    echo "keyboard: type into the window. clipboard: Ctrl+C here, Ctrl+V there."
    exit 0
  fi
  printf '.'; sleep 5
done
echo; echo "still not booted — see /tmp/emulator-$AVD.log"
exit 1
