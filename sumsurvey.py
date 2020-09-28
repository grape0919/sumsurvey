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
    print(app.config)
    return sqlite3.connect(app.config['DATABASE'])

def init_db():
    with closing(connect_db()) as db:
        with app.open_resource('rdbms\\1.CREATE_TABLES.sql') as f:
            db.cursor().executescript(f.read().decode('utf-8'))
        db.commit()

@app.before_request
def before_request():
    g.db = connect_db()

@app.teardown_request
def teardown_request(exception):
    g.db.close()

@app.route('/')
def show_entries():
    cur = g.db.execute('select * from question')
    print("!@#!@# cur : ", cur.fetchall())
    entries = []
    entries.append(dict(title="취미_종류", question="나의 취미는?"))
    entries.append(dict(title="무인도_집", question="무인도에서 일주일동안 지낼 집을 지어야 한다. 내 집은..."))
    entries.append(dict(title="무인도_화장실", question="그렇다면 무인도에서 지낼 화장실은...?"))
    entries.append(dict(title="여행_식사", question="나는 여행지에서 식사를 주로,,,"))
    entries.append(dict(title="개인_차량", question="나는 차량이 있다/없다."))
    entries.append(dict(title="", question=""))
    entries.append(dict(title="", question=""))
    entries.append(dict(title="", question=""))
    entries.append(dict(title="", question=""))
    entries.append(dict(title="", question=""))
    print("!@#!@# entries : ", entries)
    return render_template('show_entries.html', entries=entries)

if __name__ == '__main__':
    app.run()