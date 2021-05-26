# 한 학생 정보만 보유 가능한 클래스
# 학생 수 만큼 객체 생성할 경우 데이터 혼란 방지

'''
박명수,3학년,남,수학
하하,2학년,남,음악
지석진,1학년,남,미술
'''

class Student:

    # 생성자 호출 문법 : Student(값1, .., 값4)
    def __init__(self, name, grade, gender, subject):
        self.stu_name = name
        self.stu_grade = grade
        self.stu_gender = gender
        self.stu_subject = subject

    # 멤버 변수들값을 다~~ 결합해서 하나의 문자열로 반환 
    # 이 함수의 기능은 참조 변수명만 출력시에 str이 자동 실행되서 return 된 구조로 실행
    def __str__(self):
        return '학생정보 ' + self.stu_name + ' ' + self.stu_grade + ' ' + self.stu_gender + ' ' +  self.stu_subject

    # 각 멤버 변수별로 set/getXxx 메소드 보유되어 있다 가정 

    # ?grade는 1학년, 2학년, 3학년 값에 한해서만 저장
    # 유효성 검증 코드 필수 -
    def setStuGrade(self, new_grade):
        #?
        pass

    # ?gender는 남 또는 여 값에 한해서만 저장
    # 유효성 검증 코드 필수 
    def setStuGender(self, new_gender):
        pass