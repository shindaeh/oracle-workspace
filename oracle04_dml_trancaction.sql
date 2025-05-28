/*==========================================================
오라클에서 제공되는 명령어
1 DML(Data Manipulation Language 데이터 조작어) : 
  데이터는 추가, 수정, 삭제, 검색, 병합해주는 명령어들이다.
  (insert, update, delete, select, merge)
2 DDL(Data Definition Language 데이터 정의어 ) : 
  테이블의 구조를 정의, 변경해주는 명령어들이다.
  (create, drop, alter, truncate)
3 DCL(Data Control Language 데이터 제어어) : 
  사용자의 권한을 부여,제거해주는 명령어들이다.(grant ,revoke)
4 TCL(Transaction Control Language 트랜잭션 처리어) : 
  트랜잭션 설정,취소을 처리해주는 명령어들이다
  (commit, rollback, savepoint)
==========================================================*/
DROP TABLE emp01;

--테이블 구조를 복사
CREATE TABLE emp01
AS --CREATE에서 서브쿼리 적용
SELECT first_name, salary 
FROM employees
WHERE 1=0; -- 1=0;을 적은이유: employees테이블에서 first_name, salary의 구조만 가져온다.(데이터는 안가져온다)

SELECET*FROM emp01;
DESC emp01;

/*--테이블에 레코드를 삽입                   EX:first_name, salary
INSERT INTO 테이블명(column1, column2) -- 컬럼의 이름 (VALUES와 데이터타입이 동일해야한다
VALUES('값1', 값2) -- 위의 컬럼1의 값이 문자이거나 날짜일 때 , 숫자일 경우는 그냥 값만 기입
*/

INSERT INTO emp01 (first_name, salary)
VALUES('candy', 5000);

SELECT*FROM emp01;

--테이블 모든 컬럼에 데이터를 삽입할때는 컬럼몀을 생략할 수 있다.
-- 컬럼명 없이 바로 만들 수 있지만 가독성이 떨어지므로 반드시 이름을 기록하자.
INSERT INTO emp01
VALUES('Steven',4000);
SELECT*FROM emp01;

--명시적 NULL 삽입방법
INSERT INTO emp01 (first_name, salary)
VALUES('Lex', null);
SELECT*FROM emp01;

--묵시적 NULL 삽입방법
INSERT INTO emp01 (first_name)
VALUES('Paran');
SELECT*FROM emp01;

/*=======================================
테이블의 내용을 수정하는 명령어이다.
UPDATE 테이블명 
SET 컬럼1=값1, 컬럼2=값2 
WHERE 컬럼=값;
=========================================*/
--emp01테이블 first_name컬럼의 값이 'candy'일 때 조건일때(WHERE)
--salary컬럼의 값을 8000으로 업데이트하라. -- 수정하라 (SET)
UPDATE emp01
SET salary=8000
WHERE first_name='candy'; /* salary 값이 5000에서 8000으로 수정*/

SELECT*FROM emp01;

/*=============================================
테이블의 내용을 삭제하는 명령어이다.
DELETE
DELETE FROM table_name WHERE column_name = value; --1행씩 삭제 중간에 컬럼지정불가능
      이사이에는 아무것도 입력하면 안된다.
===============================================*/
DELETE FROM emp01
WHERE first_name='candy';

SELECT*FROM emp01;

/*======================================
트랜잭션(Transaction)
1 트랜잭션 정의
  -한번에 수행되어야 할 데이터베이스의 일련의 Read와
   Write 연산을 수행하는 단위
  -하나의 논리적 기능을 수행하기 위한 작업의 단위로서
  데이터베이스의 일관된 상태를 또 다른 일관된 상태로
  변환시킴
  
  트랜잭션시작-> 수정->삭제->삽입 -> 트랜잭션종료
  하나의 작업이 시작해서 정상적으로 종료될때까지의 과정을 말한다.
  (논리적인 작업단위)
  
  은행(ATM)->기계 카드삽입-> 기계가 카드를 읽음->
  인출금액 입력-> 비밀번호 입력-> 기계에서 출금액 처리
  -> 출금금액 제공-> 카드제공
  
  <트랜잭션 시작>
  -데이터베이스에 처음 접속했을 때
  -하나 또는 여러 개의 DML문이 실행된후 commit 또는 rollback
   문이 실행된 직후
  
   <트랜잭션 종료>
  - commit 또는 rollback문이 실행될때
  - DDL 또는 DCL문이 실행될 때
  - 정상적으로 데이터베이스를 종료할때
  - 비정상적으로 데이터베이스를 종료할때
  
2 트랜잭션 안전성 확보를 위한 ACID
  1) ACID정의 
     -데이터베이스에서 논리적인 작업단위인 트랜잭션이
       안전하게 수행되는 것을 보장하는 특성집합
  2) ACID의 필요성
     -다중 사용자 환경 대응 :동일데이터-다중작업환경에서의
          데이터 처리 정확성 보장
     -안전한 트랜잭션 수행을 통한 데이터베이스 무결성 유지
  3) 트랜잭성 구성요소   
    Atomicity(원자성):
     -트랜잭션은 한 개 이상의 동작을 논리적으로 한 개의
      작업단위(single unit of work)로서 분해가
      불가능한 최소의 단위
     -연산 전체가 성공적으로 처리되거나 또는 한 가지라도
      실패할 경우 전체가 취소되어 무결성을 보장
      (All or Nothing)
    Consistency(일관성):
    -트랜잭션이 실행을 성공적으로 완료하면 언제나 모순 없이
     일관성 있는 데이터베이스 상태를 보존함
    - 테이블의 데이타는 갱신되고 그에 따른 인덱스는 갱신되지 않는 등의 부정합이 있어선 않된다.
    Isolation(고립성,독립성):
    -트랜잭션이 실행 중에 생성하는 연산의 중간 결과를
     다른 트랜잭션이 접근할 수 없음
   -커밋된 트랜잭션은 장애가 발생해도 데이타가 복구되여야 한다는 특성.
   Durability(영속성,지속성,내구성):
    -성공이 완료된 트랜잭션의 결과를 영구적으로 데이터베이스에
     저장됨
========================================================================================*/
/*자동커밋 설정 확인(SQL Developer)
도구>환경설정>데이터베이스>객체뷰어> 행변경시 사후편집, 자동커밋 설정 체크 해제 */

SELECT*FROM emp01;
commit;
-- commit을 한 시점부터 트랜잭션 시작

INSERT INTO emp01
VALUES('Beta',7000);

SELECT*FROM emp01;
commit;

--중간지점을 찍을 수 있는 세이브 포인트 (변경 후 일정 되돌리고 싶을 때)
INSERT INTO emp01
VALUES('Jhon',2000);

SELECT*FROM emp01;
SAVEPOINT sp; /*중간점*/

DELETE FROM emp01
WHERE first_name='Beta';

SELECT*FROM emp01;

ROLLBACK TO sp;

SELECT*FROM emp01;

commit;

CREATE TABLE emp02(
emp_id number primary key, /* NOT NULL + UNIQUE*/
first_name varchar2(50),
salary number
);

SELECT table_name FROM user_tables;

--A세션
INSERT INTO emp02
VALUES (1, 'Park', 9000);

SELECT*FROM emp02;

commit;
SELECT*FROM emp02;
--Oracle SQL DEveloper =  A세션 , Run SQL Command Line B세션
-- A세션이 COMMIT이 되면 B세션은 해당 행에 대한 LOCK상태가 해제가 되면서 오류메세지 출력
--ORA-00001: unique constraint (HR.SYS_C006997) violated

INSERT INTO emp02
VALUES(2,'dong',8000);

SELECT*FROM emp02;
commit;
UPDATE emp02
SET first_name='min'
WHERE emp_id-2;
SELECT*FROM emp02;