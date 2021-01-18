#!/bin/bash

set -e

exec /app/virtualenv/bin/gunicorn \
    --chdir /app \
    --capture-output \
    --access-logfile=- \
    --error-logfile=- \
    --workers=${GUNICORN_WORKERS:-4} \
    -b \
    :80 \
    "$@"
