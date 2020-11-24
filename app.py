# -*- coding: utf-8 -*-
# all the imports

from __future__ import with_statement
from contextlib import closing

import sqlite3
from flask import Flask, g, render_template
from flask_bootstrap import Bootstrap

# configuration
DATABASE = 'rdbms/sumsurvey.db'
DEBUG = True
SECRET_KEY = b'aGtkZXZzdHVkaW9TdW1zdXJ2ZXk='
USERNAME = 'admin'
PASSWORD = 'default'

# create our little application :)
app = Flask(__name__)
app.config.from_object(__name__)
Bootstrap(app)

def connect_db():
    return sqlite3.connect(DATABASE)

def init_db():
    with closing(connect_db()) as db:
        with app.open_resource('rdbms/0.DROP_TABLES.sql') as f:
            db.cursor().executescript(f.read().decode('utf-8'))
        db.commit()
        with app.open_resource('rdbms/1.CREATE_TABLES.sql') as f:
            db.cursor().executescript(f.read().decode('utf-8'))
        db.commit()


@app.before_request
def before_request():
    g.db = connect_db()

@app.teardown_request
def teardown_request(exception):
    g.db.close()


@app.route('/')
def start():

    g.db.cursor().execute('update STATISTIC set CNT = (SELECT CNT FROM STATISTIC where R_ID = {ID})+1 where R_ID = {ID}'.format(ID=0))
    g.db.commit()

    return render_template('start_surv.html')

@app.route('/survey/<id>')
def show_entries(id=None):
    #질문
    cur = g.db.cursor().execute('SELECT Q_ID, TITLE, QUESTION FROM QUESTION WHERE Q_ID = {ID}'.format(ID=id))
    g.db.commit()# cur = g.db.cursor().execute('SELECT * FROM QUESTION;')
    row = cur.fetchall()[0]
    entry = dict(id=row[0], title=row[1], question=row[2])
    imgid = row[0]
    
    #답변
    cur = g.db.cursor().execute('SELECT C_NUMBER, TEXT, POINT FROM CHOICES WHERE Q_ID = {ID}'.format(ID=imgid))
    g.db.commit()# cur = g.db.cursor().execute('SELECT * FROM QUESTION;')
    choices = [dict(number=row[0], text=row[1], point=row[2]) for row in cur.fetchall()]
    
    cur = g.db.cursor().execute('SELECT MAX(Q_ID) FROM QUESTION')
    g.db.commit()# cur = g.db.cursor().execute('SELECT * FROM QUESTION;')
    row = cur.fetchall()[0]
    maxid = row[0]

    return render_template('show_entries.html', entry=entry, choices=choices, maxid=maxid, imagefile="resources/img/질문"+str(imgid)+".jpg")

@app.route('/survey/analz')
def analz():
     #질문들
    cur = g.db.cursor().execute('SELECT Q_ID, TITLE, QUESTION FROM QUESTION')
    g.db.commit()# cur = g.db.cursor().execute('SELECT * FROM QUESTION;')
    entries = [dict(id=row[0], title=row[1], question=row[2]) for row in cur.fetchall()]

    cur = g.db.cursor().execute('SELECT MAX(Q_ID) FROM QUESTION')
    g.db.commit()# cur = g.db.cursor().execute('SELECT * FROM QUESTION;')
    row = cur.fetchall()[0]
    maxid = row[0]

    #답변들
    choices = []
    for i in range(maxid):
        cur = g.db.cursor().execute('SELECT C_NUMBER, TEXT, POINT FROM CHOICES WHERE Q_ID = {ID}'.format(ID=i+1))
        g.db.commit()# cur = g.db.cursor().execute('SELECT * FROM QUESTION;')
        choices.append([dict(qid=i+1, number=row[0], text=row[1], point=row[2]) for row in cur.fetchall()])

    return render_template('analz_surv.html', entries=entries, id=1, choices=choices, maxid=maxid)

@app.route('/survey/splash/<result>')
def splash(result = None):
    return render_template('splash_surv.html', result=result)

@app.route('/survey/result/<result>')
def result(result = None):
    cur = g.db.cursor().execute('SELECT NAME FROM RESULT WHERE R_ID={ID}'.format(ID=result))
    g.db.commit()# cur = g.db.cursor().execute('SELECT * FROM QUESTION;')
    row = cur.fetchall()[0]
    name = row[0]

    g.db.cursor().execute('update STATISTIC set CNT = (SELECT CNT FROM STATISTIC where R_ID = {ID})+1 where R_ID = {ID}'.format(ID=result))
    g.db.commit()

    return render_template('result_surv.html', name=name)

#통계
@app.route('/survey/statistic')
def statistic():
    cur = g.db.cursor().execute('SELECT R_ID, CNT FROM STATISTIC where R_ID != 0')
    g.db.commit()
    cnt_list = []
    for row in cur.fetchall():
        cnt_list.append((row[0], row[1]))

    for index in range(1, len(cnt_list)+1):
        cur = g.db.cursor().execute('SELECT NAME FROM RESULT WHERE R_ID={ID}'.format(ID=cnt_list[index-1][0]))
        g.db.commit()# cur = g.db.cursor().execute('SELECT * FROM QUESTION;')
        name = cur.fetchall()[0][0]
        cnt_list[index-1] = (name ,cnt_list[index-1][1])
    
    summary = sum([row[1] for row in cnt_list])

    #방문 횟수
    cur = g.db.cursor().execute('SELECT CNT FROM STATISTIC WHERE R_ID=0')
    g.db.commit()# cur = g.db.cursor().execute('SELECT * FROM QUESTION;')
    visitCnt = cur.fetchall()[0][0]

    return render_template('statistic.html', cntlist=cnt_list, sum = summary, visit=visitCnt)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port='80')