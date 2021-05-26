class Teacher:

    def __init__(self, name, grade, subject):
        self.teach_name = name
        self.teach_grade = grade
        self.teach_subject = subject

    def __str__(self):
        return '선생님 성함 : ' + self.teach_name + ', 담당학년 : ' + self.teach_grade + ', 담당과목 : ' + self.teach_subject
