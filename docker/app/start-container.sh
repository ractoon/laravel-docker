#!/usr/bin/env bash

##
# Ensure /.composer exists and is writeable
#
if [ ! -d /.composer ]; then
  mkdir /.composer
fi

chmod -R ugo+rw /.composer

##
# Run a command or start supervisord
#
if [ $# -gt 0 ]; then
  # If a command is passed run it
  exec "$@"
else
  /usr/bin/supervisord
fi