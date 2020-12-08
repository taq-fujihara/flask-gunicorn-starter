import psycopg2

from os import environ

from flask import Flask


app = Flask(__name__)


@app.route("/")
def hello():
  with connect() as conn:
    with conn.cursor() as cursor:
      cursor.execute('select * from foo')
      for row in cursor:
        print(row)

  return "Hello, World!"


def connect():
  return psycopg2.connect('postgresql://test:testtest@localhost:5432/postgres')


if __name__ == "__main__":
  app.run(debug=True, port=environ.get('PORT', 8080))