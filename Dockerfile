FROM python:3.13-alpine3.22
LABEL maintainer="recipe-api.com"

ENV PYTHONUNBUFFERED=1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./scripts /scripts
COPY ./app /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false

RUN apk add --update --no-cache \
        python3-dev \
        build-base \
        libffi-dev \
        openssl-dev \
        zlib-dev \
        jpeg-dev \
        postgresql-dev \
        postgresql-client \
        cargo \
    && python -m venv /py \
    && /py/bin/pip install --upgrade pip \
    && /py/bin/pip install -r /tmp/requirements.txt \
    && if [ "$DEV" = "true" ]; then \
         /py/bin/pip install -r /tmp/requirements.dev.txt ; \
       fi \
    && apk del cargo build-base \
    && rm -rf /root/.cache \
    && rm -rf /tmp/* \
    && adduser --disabled-password --no-create-home django-user \
    && mkdir -p /vol/web/media \
    && mkdir -p /vol/web/static \
    && chown -R django-user:django-user /vol \
    && chmod -R 755 /vol \
    && chmod -R +x /scripts \
    && chmod +x /scripts/run.sh

ENV PATH="/scripts:/py/bin:$PATH"
USER django-user

CMD ["/scripts/run.sh"]

