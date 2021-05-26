# 학생과 선생님 정보를 file 로 부터 read해서 , 를 기준으로 데이터를 나눠서 Student와 Teacher 객체 생성 및 제공

from StudentInfo import Student

class DataPublic:
    # Student 객체 제공해주는 메소드
    # csv 일반 파일의 정보로 파이썬 객체로 생성해서 application에서 사용 가능하게 하는 로직
    def stu_public():
        with open('students.csv', 'r', encoding='utf-8') as f:
            # 박명수,3학년,남,수학 -> Student(박명수, 3학년, 남, 수학)
            data = f.readline()  
            print(data)  # 박명수,3학년,남,수학 - 하나의 문자열

            # 하나의 문자열을 , 구분자로 분해해서 list로 변환
            # , 개수에 따라 list의 데이터 수가 결정
            print(data.split(','))  # '박명수,3학년,남,수학' -> ['박명수', '3학년', '남', '수학']

            s_info = data.split(',')
            s = Student(s_info[0], s_info[1], s_info[2], s_info[3])
            print(s)   #객체를 참조하는 변수인 경우에 한해서만 str()가 자동 호출되는 구조

    # ? file 내용 다 read해서 3명의 정보의 Student 객체 생성하기
    def stu_public2():
        with open('students.csv', 'r', encoding='utf-8') as f:
            data = f.readlines()   # line별로 다 read해서 list로 자동 생성하는 기능

            # print(data)   # ['박명수,3학년,남,수학\n', '하하,2학년,남,음악\n', '지석진,1학년,남,미술']
            # print(data[0])  # 0번째 list 데이터 획득해서 출력 데이터 활용 의미

            ''' 블록 단위 주석
            list내에 몇개의 데이터가 저장되어 있는지 확인 - len() 
            그 데이터 수 만큼 Student 객체 생성 
            Student 객체들 생성해서 하나의 list에 저장 해서 관리 및 활용            
            이 로직을 호출한곳으로 list를 반환
            호출한곳에서 반복문으로 Student 정보 출력 
            '''
            # print(len(data))  # 3
            all_stu = []   # 생성된 Student 객체들을 저장하게 될 blank list

            for v in data:
                # print(v)
                # print(v.split(','))  # list로 구성하는 사유? 이름/학년/성별등의 데이터를 하나씩 뽑기 위함
                sv = v.split(',')  # '박명수,3학년,남,수학' -> ['박명수', '3학년', '남', '수학']

                # 생성된 여러개의 Student 객체들을 새로운 list에 저장해서 반환 
                # 반복 횟수만큼 list에 Student 객체 생성해서 저장
                all_stu.append(Student(sv[0], sv[1], sv[2], sv[3]))
                
            # 반복문 밖에서 all_stu에 저장된 Student들 단순 확인(출력)
            # print(all_stu[2])
            return all_stu   # Student 객체들이 저장된 list가 반환


    # csv 파일로 부터 read해서 프로그램상에서 사용 가능한 구조의 데이터 객체로 생성해서 반환(제공)
    def stu_public3():
        all_stu = []   

        with open('students.csv', 'r', encoding='utf-8') as f:
            data = f.readlines()   

            for v in data:
                sv = v.split(',')  
                all_stu.append(Student(sv[0], sv[1], sv[2], sv[3]))
        
        return all_stu  


    #? 제공해주는 학생 정보들을 반복문 통해서 출력하는 메소드
    def stu_all_print(all_stu):
        for v in all_stu:
            # Student 따라서 Strudent의 __str__
            print(v)  # __str__ 특수 메소드가 참조 변수값을 단순 출력시에는 자동 호출


    # 하나씩(단위) 기능 구현하면서 확인하는 작업을 "단위 테스트" 라고 함
    # DataPublic 클래스의 메소드 정상 실행 확인만을 위한 특수 시작 코드(main으로 읽음)
    if __name__ == '__main__':
        # stu_public()
        # stu_public2()

        # 데이터 받아와서 출력위임
        # all = stu_public3()
        # stu_all_print(all)

        # 선호하는 형식 왜? all 변수는 어차피 한번만 사용할 것이라면 가급적 선언 불필요
        stu_all_print(stu_public3())