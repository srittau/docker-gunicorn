#!/bin/bash

set -e

tail --pid $$ -F /app/log/${LOG_PREFIX}access.log &
tail --pid $$ -F /app/log/${LOG_PREFIX}error.log &
exec /app/virtualenv/bin/gunicorn \
    --chdir /app \
    --capture-output \
    --access-logfile=/app/log/${LOG_PREFIX}access.log \
    --error-logfile=/app/log/${LOG_PREFIX}error.log \
    --workers=${GUNICORN_WORKERS:-4} \
    -b \
    :80 \
    "$@"
