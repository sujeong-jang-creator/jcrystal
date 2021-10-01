# 윈도우즈 에서 설치하기.
- [튜토리얼](https://tensorflow-object-detection-api-tutorial.readthedocs.io/en/latest/index.html)
   

1. tensorflow object detection api git clone
    - https://github.com/tensorflow/models
    - git clone https://github.com/tensorflow/models

2. protobuf 설치
    - https://github.com/protocolbuffers/protobuf/releases  이동
    - os에 맞는 것 찾아서 다운. [protoc-3.16.0-win64.zip](https://github.com/protocolbuffers/protobuf/releases/download/v3.14.0/protoc-3.14.0-win64.zip)
    - 압축 풀고 bin/ 를 환경변수의 path로 잡아 준다. 
		- 다음을 명령프롬프트에서 실행해서 cmd 재실행 안해도 되게 한다.
		- set path=%path%;C:\tools\protoc-3.17.3-win64\bin 

3. research/object_detection/protos 를 컴파일
    - protoc 파일을 pb 파일로 변환 (구글 자체 포멧인 protoc 파일을 python executable 파일로 변환하는 것.)
    - models\research 디렉토리로 이동
        - cd models\research
	- protoc.exe object_detection/protos/*.proto --python_out=.

4. setup.py 를 이용해 설치
    - cd models/research/object_detection/packages/tf2 로 이동
    - setup.py 파일 수정 (pycocotools, tf-models-official 주석처리)
	- pip install .
    
# 예제 코드 실행
    - 환경설정 잡아주기
        - PYTHONPATH = models/research/ 경로 잡아준다.
	- 주피터 노트북실행    
	- models/research/object_detection/colab_tutorials/object_detection_tutorial.ipynb 실행



	
# colab 템플릿 clone
- https://github.com/dbgmlek/object_detection_workspace.git