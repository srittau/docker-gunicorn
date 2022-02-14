ARG pyversion=3.10
FROM python:${pyversion}-bullseye
ARG pyversion=3.10
ENV PYVERSION ${pyversion:-3.10}

# Prepare virtualenv
RUN mkdir -p /app/log
RUN python -m venv /app/virtualenv
RUN /app/virtualenv/bin/pip install --upgrade pip setuptools "gunicorn>=20,<21"
COPY ./run-gunicorn.sh /app/run-gunicorn.sh

# Run gunicorn
WORKDIR /app
EXPOSE 80
ENTRYPOINT ["/bin/bash", "/app/run-gunicorn.sh"]
