# -*- coding: utf-8 -*-
# all the imports

from __future__ import with_statement
from contextlib import closing

import sqlite3
from flask import Flask, g, render_template, Response
from flask_bootstrap import Bootstrap

import io
import random 
from matplotlib.backends.backend_agg import FigureCanvasAgg as FigureCanvas
from matplotlib.figure import Figure

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

    g.db.cursor().execute('update STATISTIC set CNT = (SELECT CNT FROM STATISTIC where Q_ID = {ID})+1 where Q_ID = {ID}'.format(ID=0))
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
    row = cur.fetchall()[0]
    maxid = row[0]

    #답변들
    choices = []
    for i in range(maxid):
        cur = g.db.cursor().execute('SELECT C_NUMBER, TEXT, POINT FROM CHOICES WHERE Q_ID = {ID}'.format(ID=i+1))
        choices.append([dict(qid=i+1, number=row[0], text=row[1], point=row[2]) for row in cur.fetchall()])

    return render_template('analz_surv.html', entries=entries, id=1, choices=choices, maxid=maxid)

@app.route('/survey/splash/<result>')
def splash(result = None):
    if not result == None:
        checkedList = result.split(',')
        print("checkedList = ", checkedList)
        cur = g.db.cursor().execute('SELECT MAX(ID) FROM COMPLETE_SURVEY')
        row = cur.fetchall()[0]
        print("!@#!@# ID = ", row)
        
        id = row[0]
        if( id == None ):
            id = 1
        else:
            id += 1

#http://localhost/survey/splash/,1,2,4,2,2,3,2,2
        for i in range(1,len(checkedList)):
            g.db.cursor().execute('insert into COMPLETE_SURVEY(ID, Q_ID, C_ID) values({ID},{Q_ID},{C_ID})'.format(ID=id, Q_ID=i, C_ID=checkedList[i]))
            # g.db.cursor().execute('update STATISTIC set CNT = (SELECT CNT FROM STATISTIC where Q_ID = {ID})+1 where Q_ID = {ID}'.format(ID=result))
            g.db.commit()
            
    return render_template('splash_surv.html', result=result)

#통계
@app.route('/survey/statistic')
def statistic():
    #설문 횟수
    cur = g.db.cursor().execute('SELECT MAX(ID) FROM COMPLETE_SURVEY')
    visitCnt = cur.fetchall()[0][0]

    cur = g.db.cursor().execute('SELECT B.Q_ID, B.TITLE, C.TEXT FROM COMPLETE_SURVEY A, QUESTION B, CHOICES C where A.Q_ID = B.Q_ID and A.C_ID = C.C_NUMBER and B.Q_ID = C.Q_ID')
    ans_list = []
    for row in cur.fetchall():
        ans_list.append((str(row[0]) +". "+ row[1], row[2]))

    cnt_list = {}

    for ans in ans_list:
        cnt_list.setdefault(ans,0)
        cnt_list[ans] += 1

    cnt_list = sorted(cnt_list.items())

    return render_template('statistic.html', cntlist=cnt_list, sum = visitCnt, visit=visitCnt)

#그래프
@app.route('/survey/graph')
def chart():

    fig = create_figure()
    output = io.BytesIO()
    FigureCanvas(fig).print_png(output)
    return Response(output.getvalue(), mimetype='image/png')

def create_figure():
    fig = Figure()
    axis = fig.add_subplot(1, 1, 1)
    xs = range(100)
    ys = [random.randint(1, 50) for x in xs]
    axis.plot(xs, ys)
    return fig


if __name__ == '__main__':
    app.run(host='0.0.0.0', port='80')