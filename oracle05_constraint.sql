/*===============================
테이블 구조 정의
CREATE TABLE table_name(
  column_name datatype,
  column_name datatype
);

자료형(datatype)
varchar2 - 가변길이 문자를 저장
char - 고정길이 문자를 저장
number(m)-정수저장
number(m,n)- 실수저장
date - 날짜 저장
===============================*/
CREATE TABLE student(
  name varchar2(20), --바이트(영문,특수문자- 1byte / 한글-3byte)
  age number(3),   --자릿수
  avg number(5,2), --5는 전체자릿수, 2은 소수점 자릿수
  hire date  
);

--정상삽입
INSERT INTO student(name,age,avg,hire)
VALUES('홍길동', 30, 97.85, sysdate);

SELECT*FROM student;
--오류:20바이트 초과 
--RA-12899: value too large for column "HR"."STUDENT"."NAME" (actual: 26, maximum: 20)
INSERT INTO student(name,age,avg,hire)
VALUES('박차고 나온 세상에', 30, 97.85, sysdate);

--오류:3자리까지만 가능 - 0~999만 해당
--ORA-01438: value larger than specified precision allowed for this column
INSERT INTO student(name,age,avg,hire)
VALUES('홍길동', 3000, 97.85, sysdate);
--오류:소수점은 전체자릿수 포함 X 2소수점 자리를 넘기 때문에 오류발생
--ORA-01438: value larger than specified precision allowed for this column
INSERT INTO student(name,age,avg,hire)
VALUES('홍길동', 30, 993.1385, sysdate);

SELECT*FROM student;
--오류:전차자릿수5여도 소수자리가 2 이기 때문에 오류발생
--ORA-01438: value larger than specified precision allowed for this colum
INSERT INTO student(name,age,avg,hire)
VALUES('홍길동', 30, 9731.8, sysdate);

SELECT*FROM student;
