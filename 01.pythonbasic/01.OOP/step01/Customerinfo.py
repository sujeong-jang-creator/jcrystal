# 고객(이름(cust_name), 등급(cust_grade))
# 멤버 변수 : cust_name / cust_grade
# 메소드 : 이름 제공(리턴) - getCust_name or getCustName : 선호하는 변수 이름 방식(정보 얻는거 앞에 get~)/ 등급 getXxx

class Customer:

    # 생성자 - 객체생성(실 데이터로 생성 = 멤버 변수에 값 할당 = 멤버 변수 초기화)
    def __init__(self, name, grade):
        self.cust_name = name
        self.cust_grade = grade
        print('Customer__init__')
    # 멤버변수들은 self 꼭 필요. 자기자신을 지칭하는것
    def getCustName(self):

        
        return self. cust_name