class Student:

    def __init__(self, name, grade, gender, subject):
        self.stu_name = name
        self.stu_grade = grade
        self.stu_gender = gender
        self.stu_subject = subject

    def __str__(self):
        return '학생 이름 : ' + self.stu_name + ', 학년 : ' + self.stu_grade + ', 성별 : ' + self.stu_gender + ', 담임선생님 담당과목 : ' + self.stu_subject
