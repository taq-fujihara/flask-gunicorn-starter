FROM python:3.8-slim

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ADD requirements.txt /usr/src/app/
RUN pip install -r requirements.txt

ADD main.py /usr/src/app/

CMD [ "gunicorn", "main:app", "-b", "0.0.0.0:$PORT" ]

