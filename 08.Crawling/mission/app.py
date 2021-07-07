from flask import Flask, request, render_template
# import crawling

app=Flask(__name__)

@app.route("/", methods=["get"])
def index():
    return render_template("index.html")

@app.route('/upload', methods=["post"])
def upload():
    return render_template("crawling.py")

if __name__=="__main__":
    app.run(debug=True, host="127.0.0.1", port="5000")