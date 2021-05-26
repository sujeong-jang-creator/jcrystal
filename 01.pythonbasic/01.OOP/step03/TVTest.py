# self는 생성된 해당 객체 참조 변수로 간주 하셔도 됩니다.
# 객체 생성 없는 클래스 내부에서는 self 를 사용할 필요가 없음
# self의 주용도  - 멤버 변수 호출

from TVInfo import TV

class Test:

    # list에 TV 객체들 저장해서 제공
    def tv_info_public():
        tv_all = [ TV('난 TV', 'LG'), TV('난 TV2', 'samsung') ]
        return tv_all

    # 이미 list내에 저장된 TV 객체들의 TV 이름만 출력 
    def tv_info_print(datas): # [ TV('난 TV', 'LG'), TV('난 TV2', 'samsung') ]
        for v in datas:
            print(v.getName())

    if __name__ == '__main__':

        # step02 - 데이터 받아서 활용하는 메소드 호출
        all = tv_info_public()  # [ TV('난 TV', 'LG'), TV('난 TV2', 'samsung') ]

        tv_info_print(all)  # [ TV('난 TV', 'LG'), TV('난 TV2', 'samsung') ]



        # list도 객체, __str__ 호출되는것 또한 100%, [ 보유된 객체의 주소값들..] 로직으로 구현
        # print(all)  # [<TVInfo.TV object at 0x000001D66B847850>, <TVInfo.TV object at 0x000001D66B97A1F0>]


        # step01 - 객체 생성 문법과 __str__ 자동 호출되는 내용 재 확인
        # 객체 생성해서 tv 변수에 객체의 주소값 대입
        # tv = TV('난 TV', 'LG') 
        # print(tv)   # __str__ 자동 호출 왜? 객체를 참조하는 변수(객체명 또는 객체라고 표현하기도 함)


        # # 객체 생성해서 해당 객체를 바로 출력
        # print(TV('난 TV', 'LG'))  # __str__ 자동 호출 왜? 객체를 참조하는 변수(객체명 또는 객체라고 표현하기도 함)

