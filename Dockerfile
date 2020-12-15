FROM python:3.8-alpine

COPY requirements.txt ./

# slimイメージではpsycopg2のインストールに失敗するのでその対処
# 使わないのなら削除して大丈夫
# https://github.com/Docker-Hub-frolvlad/docker-alpine-python3/issues/1#issuecomment-417053774
RUN apk update && \
  apk add postgresql-libs && \
  apk add --virtual .build-deps gcc musl-dev postgresql-dev && \
  python3 -m pip install -r requirements.txt --no-cache-dir && \
  apk --purge del .build-deps

RUN pip install gunicorn

ENV APP_HOME /app
WORKDIR $APP_HOME
COPY . ./

CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 main:app
