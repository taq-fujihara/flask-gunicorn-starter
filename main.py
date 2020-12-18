import psycopg2

from os import environ

from flask import Flask


app = Flask(__name__)


@app.route("/")
def hello():
  return "Hello, World!"


def connect():
  return psycopg2.connect(
      host=environ['PG_HOST'],
      port=environ['PG_PORT'],
      user=environ['PG_USER'],
      password=environ['PG_PASSWORD'],
      database=environ['PG_DATABASE'],
  )


if __name__ == "__main__":
  app.run(debug=True, port=environ.get('PORT', 8080))
