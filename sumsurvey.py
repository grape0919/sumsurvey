# all the imports

from __future__ import with_statement
from contextlib import closing

import sqlite3
from flask import Flask, request, session, g, redirect, url_for, \
     abort, render_template, flash

# configuration
DATABASE = 'rdbms/sumsurvey.db'
DEBUG = True
SECRET_KEY = 'development key'
USERNAME = 'admin'
PASSWORD = 'default'

# create our little application :)
app = Flask(__name__)
app.config.from_object(__name__)

def connect_db():
    return sqlite3.connect(DATABASE)

def init_db():
    with closing(connect_db()) as db:
        with app.open_resource('rdbms\\0.DROP_TABLES.sql') as f:
            db.cursor().executescript(f.read().decode('utf-8'))
        db.commit()
        with app.open_resource('rdbms\\1.CREATE_TABLES.sql') as f:
            db.cursor().executescript(f.read().decode('utf-8'))
        db.commit()

@app.before_request
def before_request():
    g.db = connect_db()

@app.teardown_request
def teardown_request(exception):
    g.db.close()

@app.route('/survey/<id>')
def show_entries(id=None):
    cur = g.db.cursor().execute('SELECT TITLE, QUESTION FROM QUESTION')
    g.db.commit()# cur = g.db.cursor().execute('SELECT * FROM QUESTION;')
    entries = [dict(title=row[0], question=row[1]) for row in cur.fetchall()]
    print("!@#!@# entries : ", entries)
    return render_template('show_entries.html', entries=entries)

@app.route('/')
def start():
    return render_template('start_surv.html', image_file="resources/img/start.jpg")

@app.route('/analz')
def analz():
    return render_template('start_surv.html')

if __name__ == '__main__':
    app.run()