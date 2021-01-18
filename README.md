# docker-gunicorn

A docker base container that contains Python and runs a gunicorn
application server.

## Configuration

The number of works to start can be configured using the `GUNICORN_WORKERS`
environment variable. It defaults to 4.
