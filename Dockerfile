ARG pyversion=3.9
FROM python:${pyversion}-buster
ARG pyversion=3.9
ENV PYVERSION ${pyversion:-3.9}

# Prepare virtualenv
RUN mkdir /app
RUN python -m venv /app/virtualenv
RUN /app/virtualenv/bin/pip install --upgrade pip setuptools gunicorn
COPY ./run-gunicorn.sh /app/run-gunicorn.sh

# Install requirements
ONBUILD COPY ./requirements.txt /app/requirements.txt
ONBUILD RUN /app/virtualenv/bin/pip --disable-pip-version-check install -q -r /app/requirements.txt

# Run gunicorn
WORKDIR /app
EXPOSE 80
ENTRYPOINT ["/bin/bash", "/app/run-gunicorn.sh"]
