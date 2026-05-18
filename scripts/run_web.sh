#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

if ! command -v flutter >/dev/null 2>&1; then
  echo "Flutter SDK not found. Install from https://docs.flutter.dev/get-started"
  echo "Then run: flutter pub get && flutter run -d chrome"
  exit 1
fi

flutter pub get
flutter config --enable-web 2>/dev/null || true

DEVICE="${1:-chrome}"
echo "Starting desktop clock on device: $DEVICE"
flutter run -d "$DEVICE"
