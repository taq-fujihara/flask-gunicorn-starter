FROM python:3.7-slim

COPY requirements.txt ./

RUN set -ex; \
  pip install -r requirements.txt; \
  pip install gunicorn

ENV APP_HOME /app
WORKDIR $APP_HOME
COPY . ./

# Install production dependencies.
# RUN pip install gunicorn

CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 main:app
