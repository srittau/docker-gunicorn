#!/bin/bash

set -e

touch /app/log/${LOG_PREFIX}access.log
touch /app/log/${LOG_PREFIX}error.log
tail --pid $$ -F /app/log/${LOG_PREFIX}access.log &
tail --pid $$ -F /app/log/${LOG_PREFIX}error.log &
exec /app/virtualenv/bin/gunicorn \
    --chdir /app \
    --capture-output \
    --access-logfile=/app/log/${LOG_PREFIX}access.log \
    --error-logfile=/app/log/${LOG_PREFIX}error.log \
    --workers=${GUNICORN_WORKERS:-4} \
    --bind=:80 \
    "$@"
