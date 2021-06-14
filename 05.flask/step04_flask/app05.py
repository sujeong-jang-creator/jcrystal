from flask import Flask, render_template
from flask import request

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('step05request.html')


@app.route('/login', methods=['post'])
def login():


    id = request.form.get('id')  
    pw = request.form.get('pw') 

    # info = {"name":"재석", "age":30}
    info = {"name" : id, "password" : pw}

    return render_template('step05response.html', idencore=id, userinfo=pw)


if __name__ == '__main__':
    app.run(debug=True)