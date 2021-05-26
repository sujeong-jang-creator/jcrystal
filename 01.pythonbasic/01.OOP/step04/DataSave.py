from TeacherInfo import Teacher
from StudentsInfo import Student

class DataPublic:

    def teach_public():
        all_teach = []

        with open('Teachers.csv', 'r', encoding='utf-8') as f:
            data = f.readlines()

            for v in data:
                tv = v.split(',')
                all_teach.append(Teacher(tv[0], tv[1], tv[2]))

        return all_teach


    def all_teacher(all_teach):

        for v in all_teach:
            print(v)

    def stu_public():
        all_stu = []

        with open('Students.csv', 'r', encoding='utf-8') as f:
            data = f.readlines()

            for v in data:
                sv = v.split(',')
                all_stu.append(Student(sv[0], sv[1], sv[2],sv[3]))

        return all_stu

    def all_student(all_stu):

        for v in all_stu:
            print(v)

    if __name__ == '__main__':
        all_t = teach_public()
        all_teacher(all_t)

        print(sep='\n')
        print('-' * 70)

        all_s = stu_public()
        print(sep='\n')
        all_student(all_s)
