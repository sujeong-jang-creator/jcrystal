from django.shortcuts import render, redirect
# 모델클래스들 import
from .models import Question, Choice

# View: 사용자 요청을 처리하는 함수(Work flow). 기능별로 작성.
# 설문 목록을 보여주는 View함수
# 1. DB에서 설문 목록 조회
# 2. question_text만 추출해서 List 생성
# 3. 응답 화면을 생성해서 반환 -> Template 사용.

# View함수: 이름-알아서 만든다. 매개변수: 1-HttpRequest를 받는 변수
# View함수를 poll/urls.py 에 등록 -> 사용자요청 URL-View함수 매핑
def list(request):
    question_list = Question.objects.all()

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

    question = Question.objects.get(pk=question_id)

    return render(request, 'poll/vote_form.html', {"question":question})

# 투표 처리 View 함수
# 요청파라미터조회
    # POST방식 요청 처리: request.POST['name'], request.POST.get('name', [,default=기본값])
    # GET방식 요청 처리: request.GET['name'], request.GET.get('name')
    # [] 조회: 없는 name으로 조회할 경우 exception발생
    # .get(): 없는 name으로 조회할 경우 default 값 반환. (default=None)

def vote(request):
    # 요청 파라미터 조회: choice=id, question_id=id
    choice_id = request.POST['choice']
    question_id = request.POST['question_id']
    print("vote(): ", choice_id, question_id)
    # Choice를 update: 선택된 choice.id   update choice set vote=vote+1 where id = 선택된 id
    # 1. Choice 조회, 2. vote 변경, 3. save()
    choice = Choice.objects.get(pk=choice_id)
    choice.vote = choice.vote + 1
    choice.save()

    url = f"/poll/vote_result/{question_id}"
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