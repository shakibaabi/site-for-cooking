#!/usr/bin/env sh
set -eu
cd "$(dirname "$0")"
if ! command -v node >/dev/null 2>&1; then
  echo 'Please install Node.js 20 or later first.'
  exit 1
fi
if [ ! -d node_modules ]; then npm ci; fi
if [ ! -f dist/index.html ]; then npm run build; fi
echo 'Demo: http://localhost:3000  |  Admin: admin / demo12345'
exec npm run demo
