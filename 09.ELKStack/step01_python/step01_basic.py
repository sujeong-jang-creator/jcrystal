from datetime import datetime
from elasticsearch import Elasticsearch
from elasticsearch.transport import get_host_info
es = Elasticsearch()

# 데이터 생성 및 확인하는 함수
def put():
    doc = {
        'author': 'kimchy',
        'text': 'Elasticsearch: cool. bonsai cool.',
        'timestamp': datetime.now(),
    }
    # PUT test-index/_doc/1
    res = es.index(index="test-index", id=1, body=doc)
    # GET test-index/_doc/1
    print(res['result'])
    print("*************1************")

'''
es.index(index="test-index", id=1, body=doc)
es : Elasticsearch 객체
index() : ES보유한 index 생성 함수
* 용어 정리 : index 생성은 RDBMS 관점에서 table생성 + 데이터 저장
index = : index 명
test-index : index로 사용할 이름을 설정
id : pk와 같이 고유한 id 설정 의미
=1 : id값으로 1dmlal
body : index에 설정한 table과 같은 index구조에 id값과
=doc : dict 구조의 변수값으로 index에 새로운 데이터 생성
'''

# 소스보기(내용물 보기)
# GET test-index/_doc/1
def get():
    res = es.get(index="test-index", id=1)
    print(res['_source'])
    print("*************2************")

# index를 새로고침
# https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-refresh.html
# es.indices.refresh(index="test-index")

# 정보찾기
def match_all():

    '''
    GET test-index/_search
    {
        "query": {
            "match_all": {}
        }
    }
    '''
    res = es.search(index="test-index", body={"query": {"match_all": {}}})

    # %d : 가변적인 데이터 단 d는 디지털 약자 즉 숫자를 의미
    print("Got %d Hits:" % res['hits']['total']['value'])
    print("*************3************")

    for hit in res['hits']['hits']:
        print("%(timestamp)s %(author)s: %(text)s" % hit["_source"])
        print("*************4************")


#국민은행 지점별 customers 출력
def bank():
    es = Elasticsearch(hosts='127.0.0.1:9200',http_compress=True)
    res = es.search(index="bank", body={"query": {"match": { "bank": "국민은행"}}})
    print(res)
    print("집계 개수 %d" % res['hits']['total']['value'])
    # print(res['aggregations'])

def bank_get2():
    res = es.search(index="bank", body={"query": { "match": { "bank": "국민은행" }},"size": 0,  "aggs": { "b_1": {"terms": { "field": "customers"}}}})
    # print(res['aggregations']['b_1']['buckets'][0]['key'])

    datas = res['aggregations']['b_1']['buckets']
    print(datas)

    for data in datas:
        print('key:', data['key'])

#     res = es.search(index="bank", body={"query" : {"match" : { "bank" : "국민은행"}}, "size" )
# {
#   "query": {
#     "match": {
#       "bank": "국민은행"
#     }
#   },
#   "size": 0, 
#   "aggs": {
#     "b_3": {
#       "stats": {
#         "field": "customers"
#       }
#     }
#   }
# }

if __name__=="__main__":
    # put()
    # get()
    # match_all()
    # bank()
    bank_get2()