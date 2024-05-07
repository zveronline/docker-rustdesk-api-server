FROM python:3.10.3-alpine

WORKDIR /rustdesk-api-server
ADD https://github.com/kingmo888/rustdesk-api-server/archive/refs/heads/master.zip /rustdesk-api-server.zip

RUN apk add --no-cache -U unzip \
    && unzip /rustdesk-api-server.zip && rm /rustdesk-api-server.zip && mv rustdesk-api-server-*/* /rustdesk-api-server/

RUN set -ex \
    && pip install --no-cache-dir --disable-pip-version-check -r requirements.txt \
    && rm -rf /var/cache/apk/* \
    && cp -r ./db ./db_bak

ENV HOST="0.0.0.0"
ENV TZ="Europe/Moscow"

EXPOSE 21114/tcp
EXPOSE 21114/udp

ENTRYPOINT ["sh", "run.sh"]
