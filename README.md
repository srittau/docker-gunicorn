# docker-gunicorn

A docker base container that contains Python and runs a gunicorn
application server.

If a `requirements.txt` file exists in the top-level directory, the
packages listed there are installed into the generated container.

## Configuration

The number of works to start can be configured using the `GUNICORN_WORKERS`
environment variable. It defaults to 4.

The gunicorn logs are written to stdout, but also stored in two files
in `/app/log` inside the container. By default, those are named
`access.log` and `error.log`, but a prefix can be configured using the
`LOG_PREFIX` environment variable. This allows multiple containers to
share a volume.

## Example Dockerfile

Suppose your application lives in `src/flubber` and you have a package
called `flubber.app` that contains a WSGI application with entrypoint
`application`. The following `Dockerfile` will create an gunicorn image
running that application:

```
FROM srittau/gunicorn:latest
COPY ./src/flubber /app/flubber
CMD ["flubber.app"]
```
