#!/usr/bin/env bash
set -u
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PYTHON=""
if command -v python >/dev/null 2>&1; then
  PYTHON="$(command -v python)"
elif command -v python3 >/dev/null 2>&1; then
  PYTHON="$(command -v python3)"
else
  if command -v pkg >/dev/null 2>&1; then
    echo "[CYTHANX MOG] Python 3 not found; installing with pkg..."
    pkg update -y || exit 1
    pkg install -y python || exit 1
    PYTHON="$(command -v python || command -v python3)"
  else
    echo "[CYTHANX MOG] Python 3 is required." >&2
    exit 127
  fi
fi
SCRIPT="$SCRIPT_DIR/cythanx_mog_single_operation.py"
if [ ! -f "$SCRIPT" ]; then
  echo "[CYTHANX MOG] Missing $SCRIPT" >&2
  exit 1
fi
exec "$PYTHON" "$SCRIPT" "$@"
