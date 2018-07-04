FROM python:3.7-stretch

# Prepare virtualenv
RUN mkdir /app
RUN python3.7 -m venv /app/virtualenv
RUN /app/virtualenv/bin/pip install --upgrade pip setuptools gunicorn

# Install requirements
ONBUILD COPY ./requirements.txt /app/requirements.txt
ONBUILD RUN /app/virtualenv/bin/pip install -q -r /app/requirements.txt

# Run gunicorn
WORKDIR /app
EXPOSE 80
ENTRYPOINT ["/app/virtualenv/bin/gunicorn", "--capture-output", "--access-logfile=-", "--error-logfile=-", "--workers=4", "-b", ":80"]
