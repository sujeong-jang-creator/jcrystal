from flask import Flask

# Flask 객체(instance) 생성
app = Flask(__name__)

# url 설정 - http://ip:port/ 또는 http://ip:port 형식으로 구성
# @ : 장식자
@app.route('/playdata')
def index():
    return '{"name":"유재석"}'


if __name__ == '__main__':
    # Flask 로 실행하기 위한 필수 코드 
    # debug=True 설정시 서버가 실행중임에도 소스 수정 -> 자동 갱신이 가능 
    app.run(debug=True)  