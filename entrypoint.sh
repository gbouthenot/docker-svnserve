#!/bin/bash

set -e # exit on any error
# set -x # debug

if [ ! -d "/opt/svn/conf" ]; then
    echo "==> could not find config directory: /opt/svn/conf"
    svnadmin create /opt/svn
    echo "==> created new svn respository in /opt/svn"
fi

if [ "$1" = 'default' ]; then
  exec /usr/bin/supervisord -c /etc/supervisor/supervisord.conf
fi

exec "$@"
