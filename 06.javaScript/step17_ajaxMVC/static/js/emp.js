/* json 포멧의 문자열을 json 객체로 변환
demo의 위치에 table 생성해서 직원수 만큼 row
table의 row tag는 동일
    반복문 + 데이터만 가변적으로 json으로 부터 뽑음
        <tr><td>사번</td><td>이름</td><td>급여</td></tr>
    json 에 직원수 파악
    파악한 수 만큼 반복  */
//https://poiemaweb.com/es6-template-literals
function empall(){
    const xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            data = this.responseText;
            data = JSON.parse(data);

            tab = `
            <table border="1">
                <tr><th>사번</th><th>이름</th><th>급여</th></tr>`;
            let empno;
            let ename;
            let sal;
            for(no in data){
                empno = data[no].empno;
                ename = data[no].ename;
                sal = data[no].sal;

                tab = tab + `<tr>
                    <td>${empno}</td>
                    <td>${ename}</td>
                    <td>${sal}</td>
                </tr>`;
            }
            tab = tab + `</table>`;
            document.getElementById("demo").innerHTML = tab;
        };
    };
    xhttp.open("GET", "emplist");   
    xhttp.send();
}

