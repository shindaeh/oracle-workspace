/*=====================================================
SQL(structured query language)함수
1. 단일행함수 : 행 하나당 하나의 결과를 출력한다
              (문자함수, 숫자함수, 날짜함수, 변환함수, 일반함수)
2. 복수행함수 : 행 여러개당 하나의 결과를 출력한다
               (합계, 평균, 최대, 최소, 갯수)  
====================================================== 
--SELECT문에서는 반드시 테이블명을 명시해야 한다.
--그래서 SELECT절에 식이나 특정함수를 이용해서 결과값을 가져올때
-- 사용할 수 있는 DUAL이라는 테이블을 제공하고 있다. */

SELECT 3+1
FROM dual; -- + 식

SELECT sysdate -- 특정함수 (현재 날짜)
FROM dual; 

SELECT max(10) -- 아규먼트 1개 , 컬럼 값
FROM dual;

SELECT SUBSTR('korea',1,3) -- korea라는 문자열에서 1인덱스부터 3개를 가져와라. (오라클은 인덱스가 1부터 시작)
FROM dual;

--문자함수
--단어의 첫글자만 대문자로 변경해주는 함수이다.
SELECT initcap('korea hello')
FROM dual;

-- 모든 문자를 대문자로 변경해 주는 함수이다.
SELECT upper('korea')
FROM dual;

SELECT first_name, upper(first_name),
last_name,upper(last_name)
FROM employees;

--모든 문자를 소문자로 변경해주는 함수이다.
SELECT lower('KOREA')
FROM employees;

SELECT first_name, lower(first_name),
last_name,lower(last_name)
FROM employees;

----employees테이블 first_name에서 대소문자 구분없이
--'Ja'가 포함이 된 first_name, salary을 출력하라.
SELECT first_name, salary
FROM employees
WHERE upper(first_name) LIKE upper('%ja%');

--문자의 길이를 리턴해주는 함수이다.
SELECT length('kroea')
FROM dual;

SELECT length('한국')
FROM dual;

SELECT lengthb('kroea')
FROM dual;

SELECT lengthb('한국')
FROM dual;

--테이블을 설계했다 5칸짜리
CREATE TABLE user1(
data varchar2(5)
);

SELECT*FROM user1;
--ORA-12899: value too large for column "HR"."USER1"."DATA" (actual: 11, maximum: 5)
INSERT INTO user1(data)
VALUES('south korea');

--ORA-12899: value too large for column "HR"."USER1"."DATA" (actual: 6, maximum: 5)
--CRATE TABLE data varchar2(5)에서  저장할 수 있는 공간이 5개인데 범위를 벗어나기 때문에 오류가 생겻음 
INSERT INTO user1(data)
VALUES('한국');