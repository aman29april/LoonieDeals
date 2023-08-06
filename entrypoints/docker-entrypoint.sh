#!/bin/sh

set -e

unset BUNDLE_PATH
unset BUNDLE_BIN

if [ -f tmp/pids/server.pid ]; then
  echo "Deleting server.pid file..."
  rm tmp/pids/server.pid
fi

exec "$@"

echo "Starting rails server..."
bundle exec rails s -b 0.0.0.0
