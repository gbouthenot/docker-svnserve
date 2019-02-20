#!/bin/bash

set -e # exit on any error
# set -x # debug

for repo in * ; do
  echo "Found existing repository: $repo"
done

if [ "$1" = 'default' ]; then
  exec /usr/bin/supervisord -c /etc/supervisor/supervisord.conf
fi

exec "$@"
