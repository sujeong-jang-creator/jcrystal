from django.shortcuts import render, redirect
from django.urls import reverse # urls.py에 등록된 path 이름을 이용해 url을 생성하는 함수

# 모델클래스들 import
from .models import Question, Choice

# View: 사용자 요청을 처리하는 함수(Work flow). 기능별로 작성.
# View 함수
'''
    1. 사용자가 전송한 파라미터(요청파라미터, Path parameter) 조회
    2. 사용자가 전송한 파라미터 검증 (Validation)
        - 필수 파라미터의 전송 여부
        - 값에 대한 조건을 확인. (타입, 범위, 글자수 등등)
        - 검증 실패할 경우 Error처리 페이지로 이동
    3. Business logic 처리 -> 요청한 작업을 처리
        - DB 작업은 Model 호출
    4. 처리결과를 응답처리
        - Template 호출 (render()), 다른 View를 호출(redirect())
'''



# 설문 목록을 보여주는 View함수
# 1. DB에서 설문 목록 조회
# 2. question_text만 추출해서 List 생성
# 3. 응답 화면을 생성해서 반환 -> Template 사용.

# View함수: 이름-알아서 만든다. 매개변수: 1-HttpRequest를 받는 변수
# View함수를 poll/urls.py 에 등록 -> 사용자요청 URL-View함수 매핑
def list(request):
    question_list = Question.objects.all()

    # 응답
    response = render(request,
                    "poll/list.html",  # 응답을 처리한 template 파일. poll/templates/poll/list.html
                    {"question_list":question_list})  # template에 전달 값을 name-value 쌍의 dictionary.

    return response

# vote_form 처리 View 함수
# 매개변수: 1. HttpRequest, 2. question_id : Path Parameter로 전달된 질문 id를 받을 변수
def vote_form(request, question_id):
    print("vote_form(): question_id", question_id)
    print("--------------------------------------")
    # quesiton_id로 Question+Choice을 조회해서 template으로 전달

    try:
        # get(): 1개 조회, 조회결과가 없거나(0) 2개이상인경우 Exception 발생.
        question = Question.objects.get(pk=question_id)
        return render(request, 'poll/vote_form.html', {"question":question})
    except:
        # 없는 question_id로 조회한 경우 => 사용자가 없는 id의 설문을 요청
        return render(request, 'poll/error_page.html', {"error_message":"없는 설문번호를 요청했습니다."})


# 투표 처리 View 함수
# 요청파라미터조회
    # POST방식 요청 처리: request.POST['name'], request.POST.get('name', [,default=기본값])
    # GET방식 요청 처리: request.GET['name'], request.GET.get('name')
    # [] 조회: 없는 name으로 조회할 경우 exception발생
    # .get(): 없는 name으로 조회할 경우 default 값 반환. (default=None)

def vote(request):
    # 요청 파라미터 조회: choice=id, question_id=id
    # choice_id = request.POST['choice'] # choice 요청파라미터가 없는 경우.
    choice_id = request.POST.get('choice')
    question_id = request.POST['question_id']


    # 요청 파라미터 검증(validation) - 필수 요청파라미터가 잘 전송되었는지 체크
    # 보기를 선택하지 않고 조회한 경우 => vote_form.html을 호출
    if choice_id == None:
        question = Question.objects.get(pk=question_id)
        return render(request, "poll/vote_form.html", {'question':question, "error_message":"보기를 선택하세요."})


    print("vote(): ", choice_id, question_id)
    # Choice를 update: 선택된 choice.id   update choice set vote=vote+1 where id = 선택된 id
    # 1. Choice 조회, 2. vote 변경, 3. save()
    choice = Choice.objects.get(pk=choice_id)
    choice.vote = choice.vote + 1
    choice.save()

    # url = f"/poll/vote_result/{qustion_id}""
    url = reverse("poll:vote_result", args=[question_id]) # ("path name", args=[path 파라미터에 전달할 값, ...])
    print('redirect url: ', url)
    return redirect(to=url)

    # 1
    # return redirect(to = "https://www.daum.net/")

    # 2
    # # Question을 select: 질문 ID. select * from question where id=질문 id
    # question = Question.objects.get(pk=question_id)

    # # 응답처리
    # return render(request, "poll/vote_result.html", {'question':question})


# 개별 설문의 결과를 보여주는 View
def vote_result(request, question_id):
    question = Question.objects.get(pk=question_id)

    return render(request, 'poll/vote_result.html', {"question":question})