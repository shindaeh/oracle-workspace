/*=======================================================
join : 여러개의 테이블에서 원하는 테이블을 추출해주는 쿼리문이다.

join은 oracle제품에서 사용되는 oracle용 join이 있고
모든 제품에서 공통적으로 사용되는 표준(ANSI) join이 있다.
========================================================*/
--1. carteian product(카티션 곱) 조인 : 
--   테이블 행의 갯수만큼 출력해주는 조인이다.
--1) oracle용 cartesian product
  SELECT e.department_id, e.first_name, e.job_id, j.job_title
  FROM employees e, jobs  j; --2,033
  --employees을 e로 AS해줫다. // 테이블이 2개 이기 때문에 AS이용해서 명확하게 해준다.
  
  --테이블이 2개로 늘어났다!
  SELECT *
  FROM employees; --107
  SELECT *
  FROM jobs;  --19
  
--(2) ANSI용 cross join
 SELECT e.department_id, e.first_name, e.job_id, j.job_title
 FROM employees e cross join jobs  j; 
 -- ANSI에서는 , 대신에 cross를 사용한다.
 
  /*
 2. equi join
    가장 많이 사용되는 조인방법으로 조인 대상이 되는 두 테이블에서 공통적으로 존재하는 컬럼의 값이
    일치되는 행을 연결하여 결과를 생성하는 방법이다.
 */
 --(1) oracle용 equi join
  SELECT e.department_id, e.first_name, e.job_id, j.job_title
  FROM employees e, jobs  j
  WHERE e.job_id=j.job_id;
 
--(2) ansi용 inner join
 SELECT e.department_id, e.first_name, e.job_id, j.job_title  
  FROM employees e inner join jobs  j  
  ON e.job_id=j.job_id;

--employees와 departments테이블에서 사원번호(employee_id),
--부서번호(department_id), 부서명(department_name)을 검색하시오.
SELECT e.employee_id, d.department_id, d.department_name -- (명확한 값을 가져오기 위해서 d,e를 붙인다)
FROM employees e, departments d --(테이블)
WHERE e.department_id = d.department_id; --(두개의 테이블에서 공통점이 일치가 될때)

--ANSI
SELECT e.employee_id, d.department_id, d.department_name -- (명확한 값을 가져오기 위해서 d,e를 붙인다)
FROM employees e inner join departments d --(테이블)
ON e.department_id = d.department_id;

--employees와 departments테이블에서 사원번호(employee_id),
--부서번호(department_id), 부서명(department_name)을 검색하시오.
SELECT e.employee_id , e.job_id, j.job_title
FROM employees e , jobs j 
WHERE e.job_id=j.job_id; -- =로 서로 일치하는것만 가져온다. (왜 쌩뚱맞은 값이 나와도 거겅없는지)

SELECT e.employee_id , e.job_id, j.job_title
FROM employees e inner join jobs j 
On e.job_id=j.job_id; -- =로 서로 일치하는것만 가져온다. (왜 쌩뚱맞은 값이 나와도 거겅없는지)

 --job_id가 'FI_MGR'인 사원이 속한(사원이 속한 자료는 employee)
 --급여(salary)의 최소값(min_salary), 최대값(max_salary)을 출력하시오. 
SELECT e.first_name, e.job_id, j.min_salary ,j.max_salary
FROM jobs j , employees e
WHERE j.job_id = e.job_id
   AND e.job_id = 'FI_MGR'; --전체 조건에서 e.job_id='FI_MGR해당하는 것
   
   --ANSI
SELECT e.first_name, e.job_id, j.min_salary ,j.max_salary
FROM jobs j inner join employees e
On j.job_id = e.job_id
WHERE e.job_id = 'FI_MGR'; 

--부서가 'Seattle'에 있는 부서에서 근무하는
--직원들의  first_name, hire_date, department_name, city
--출력하는 SELECT을 작성하시오.
SELECT e.first_name, e.hire_date, d.department_name, l.city
FROM employees e, departments d, locations l --(테이블 3개)
WHERE e.department_id=d.department_id
 AND  d.location_id=l.location_id -- 1그룹 e,d따로 , 2그룹 d,l따로 공통점
 AND  l.city='Seattle'; --조건부에 Seattle들어가서 AND 추가

SELECT e.first_name, e.hire_date, d.department_name, l.city
FROM employees e  INNER JOIN    departments d   ON  e.department_id=d.department_id -- 2개 그룹 먼저
                  INNER JOIN  locations l  ON      d.location_id=l.location_id -- 2개 그룹 나중에
WHERE  l.city='Seattle';

--20번 부서의 이름과 그 부서에 근무하는사우너의 이름(first_name)을 출력하시오
SELECT d.department_id , e.first_name , d.department_name
FROM employees e , departments d
WHERE e.department_id=d.department_id
AND d.department_id=20;

--ANSI
SELECT d.department_id , e.first_name , d.department_name
FROM employees e INNER JOIN departments d
ON e.department_id=d.department_id
WHERE d.department_id=20;

--1400, 1500번 위치의 도시이름과 그 곳에 있는 부서의 이름을 출력하시오.
SELECT l.location_id, l.city, d.department_name
FROM locations l, departments d
WHERE l.location_id=d.location_id 
  AND l.location_id IN(1400, 1500);
  
SELECT l.location_id, l.city, d.department_name
FROM locations l INNER JOIN departments d
ON l.location_id=d.location_id 
WHERE l.location_id IN(1400, 1500);  

/*===================================
3. non-equi join (비등가조인)
  (=)동등비교연산자를 제외한 >=, <=, >, <등의 연산자를 
  이용해서 조건을 지정하는 조인방법이다.
  무언가의 범위를 조사할때
=======================================*/
--(1) oracle용 non-equi join
SELECT e.first_name, e.salary, j.min_salary,
               j.max_salary, j.job_title
FROM employees e, jobs j               
WHERE  e.job_id=j.job_id
  AND e.salary>=j.min_salary
       AND e.salary<=j.max_salary;

--(2) ansi용 non-equi join
SELECT e.first_name, e.salary, j.min_salary,
       j.max_salary, j.job_title
FROM employees e JOIN jobs j
ON e.job_id=j.job_id
WHERE e.salary>=j.min_salary
AND e.salary<=j.max_salary;

/*=================================================================
4. outer join
  한 테이블에는 데이터가 있고 다른 반대쪽에는 데이터가 없는 경우에
  데이터가 있는 테이블의 내용을 모두 가져오는 조건이다.
  https://dataschool.com/how-to-teach-people-sql/left-right-join-animated/
  ===============================================================*/
--(1) oracle outer join
  SELECT e.employee_id, e.first_name, e.employee_id, e.department_id, 
          d.department_id, d.department_name 
  FROM employees e, departments d
  WHERE e.department_id=d.department_id(+)
  ORDER BY e.employee_id;  /* LEFT OUTER JOIN*/

 SELECT e.first_name, e.employee_id,
        e.department_id, d.department_id, d.department_name
 FROM employees e, departments d
 WHERE e.department_id(+)=d.department_id; /* RIGHT OUTER JOIN */

 --(2) ansi outer join
  SELECT e.first_name, e.employee_id,
        e.department_id, d.department_id, d.department_name
 FROM employees e LEFT OUTER JOIN departments d
 ON e.department_id=d.department_id;
 
 SELECT e.first_name, e.employee_id,
        e.department_id, d.department_id, d.department_name
 FROM employees e RIGHT OUTER JOIN departments d
 ON e.department_id=d.department_id;
 
 SELECT e.first_name, e.employee_id,
        e.department_id, d.department_id, d.department_name
 FROM employees e FULL OUTER JOIN departments d
 ON e.department_id=d.department_id;

 /*=================================================
5. self join
 하나의 테이블을 두개의 테이블로 설정해서 사용하는 조인방법이다.
 하나의 테이블에 같은데이터가 두개의 컬럼에 다른 목적으로 저장되여 있는 경우
 employees, employee_id, manager_id
====================================================*/
 --(1) oracle self join
 SELECT w.employee_id AS "사원번호",
               w.first_name AS "사원이름",
              w.manager_id  AS "관리자번호",
             m.first_name AS "관리자이름"
 FROM employees w, employees m --자기자신참조(하나의 테이블이 2개로 보여지는 거라 생각하기)
 WHERE w.manager_id=m.employee_id
 ORDER BY w.employee_id;
 
 
 --(2) ansi self join
SELECT w.employee_id AS "사원번호",
        w.first_name AS "사원이름",
        w.manager_id  AS "관리자번호",
        m.first_name AS "관리자이름"
 FROM employees w  JOIN employees m
 ON w.manager_id=m.employee_id
 ORDER BY w.employee_id;
 
--USING :두 테이블 간 조인 조건에 사용되는 컬럼명이 동일한 경우 USING을 사용한다.
-- 하지만 다른 경우도 많으므로 USING 대신 ON 절을 사용하는 것이 일반적이다.

SELECT department_id, first_name, job_id, job_title

FROM employees

INNER JOIN jobs USING(job_id);

SELECT first_name, hire_date, department_name, city

FROM employees

INNER JOIN departments USING(department_id)

INNER JOIN locations USING(location_id)

WHERE? city='Seattle';

/*----------------------------------------------
 문제
 ----------------------------------------------   */
--1)EMPLOYEES 테이블에서 입사한 달(hire_date) 별로 인원수를 조회하시오 . 
--  <출력: 월        직원수   >
SELECT to_char(hire_date,'mm') || '월' AS "월", count(*) AS "직원수"
FROM employees
GROUP BY to_char(hire_date,'mm')
ORDER BY to_char(hire_date,'mm');


--2)각 부서에서 근무하는 직원수를 조회하는 SQL 명령어를 작성하시오. 
--단, 직원수가 5명 이하인 부서 정보만 출력되어야 하며 부서정보가 없는 직원이 있다면 부서명에 “<미배치인원>” 이라는 문자가 출력되도록 하시오. 
--그리고 출력결과는 직원수가 많은 부서먼저 출력되어야 합니다.
 SELECT nvl(d.department_name, '<미배치인원>'), count(*) 
 FROM employees e, departments d
 WHERE e.department_id=d.department_id(+)   /* LEFT OUTER JOIN */
GROUP BY d.department_name
HAVING count(*) <= 5
ORDER BY count(*) DESC;
 

--3)각 부서 이름 별로 2005년 이전에 입사한 직원들의 인원수를 조회하시오.   /*  이전 <=, 이후 >=   4월 21일전(<)   4월 21일이전(<=) */ 
-- <출력 :    부서명		입사년도      	인원수  >
 SELECT d.department_name AS "부서명",   to_char(e.hire_date, 'yyyy') AS "입사년도" ,  count(*) AS "인원수"
 FROM employees e, departments d
 WHERE e.department_id=d.department_id(+)
 GROUP BY d.department_name, to_char(e.hire_date, 'yyyy')
 HAVING to_char(e.hire_date, 'yyyy') <= '2005'
 ORDER BY to_char(e.hire_date, 'yyyy') DESC; 
 
--4)직책(job_title)에서 'Manager'가 포함이된 사원의 이름(first_name), 직책(job_title), 부서명(department_name)을 조회하시오.
  SELECT e.first_name, j.job_title, d.department_name
  FROM employees e, jobs j, departments d
  WHERE e.job_id=j.job_id
   AND e.department_id=d.department_id
   AND j.job_title LIKE '%Manager%';
  
--5)'Executive' 부서에 속에 있는 직원들의 관리자 이름을 조회하시오. 
--단, 관리자가 없는 직원이 있다면 그 직원 정보도 출력결과에 포함시켜야 합니다.
 --<출력 : 부서번호 직원명  관리자명  > 
 SELECT e.department_id AS "부서번호", e.first_name AS "직원명",  m.first_name AS "관리자명"
 FROM employees e, employees m,  departments d 
 WHERE e.department_id=d.department_id
   AND e.manager_id = m.employee_id(+)
 AND d.department_name='Executive';


--USING :두 테이블 간 조인 조건에 사용되는 컬럼명이 동일한 경우 USING을 사용한다.
--       하지만 다른 경우도 많으므로 USING 대신 ON 절을 사용하는 것이 일반적이다.
SELECT department_id, first_name, job_id, job_title  
FROM employees  
INNER JOIN jobs USING(job_id);
   
SELECT first_name, hire_date, department_name, city
FROM employees 
INNER JOIN departments USING(department_id)
INNER JOIN locations USING(location_id)
WHERE  city='Seattle';

/*-----------------------------------------------------------------------------------------
서브쿼리(subquery)
 하나의 SQL문안에 포함되어 있는 또 다른 SQL문을 말한다.
 서브쿼리는 알려지지 않은 기준을 이용한 검색을 위해 사용한다.
 서브쿼리는 메인쿼리가 서브쿼리를 포함하는 종속적인 관계이다.
 서브쿼리는 메인쿼리의 컬럼을 모두 사용할 수 있지만 메인쿼리는 서브쿼리의 컬럼을 사용할 수 없다. 
 질의 결과에 서브쿼리 컬럼을 표시해야 한다면 조인방식으로 
    변환하거나 함수, 스칼라 서브쿼리(scarar subquery)등을 사용해야 한다. 
 조인은 집합간의 곱(Product)의 관계이다. 
 
외부 쿼리 (메인쿼리)
 :일반 쿼리를 의미합니다.
스칼라 서브쿼리
 :SELECT 절에 쿼리가 사용되는 경우로, 함수처럼 레코드당 정확히 하나의 값만을 반환하는 서브쿼리입니다.
인라인 뷰
 :FROM 절에 사용되는 쿼리로, 원하는 데이터를 조회하여 가상의 집합을 만들어 조인을 수행하거나 가상의 집합을 다시 조회할 때 사용합니다.



서브쿼리를 사용할 때 다음 사항에 주의
  서브쿼리를 괄호로 감싸서 사용한다. 
  서브쿼리는 단일 행(Single Row) 또는 복수 행(Multiple Row) 비교 연산자와 함께 사용 가능하다. 
  단일 행 비교 연산자는 서브쿼리의 결과가 반드시 1건 이하이어야 하고 복수 행 비교 연산자는 서브쿼리의 결과 건수와 상관 없다. 
  서브쿼리에서는 ORDER BY를 사용하지 못한다. 
  ORDER BY절은 SELECT절에서 오직 한 개만 올 수 있기 때문에 ORDER BY절은 메인쿼리의 마지막 문장에 위치해야 한다.
  

서브 쿼리 사용가능한 위치
SELECT, FROM, WHERE, HAVING,ORDER BY 
INSERT문의 VALUES,
UPDATE문의 SET, 
CREATE문

서브쿼리의 종류는 동작하는 방식이나 반환되는 데이터의 형태에 따라 분류할 수 있다.
1 동작하는 방식에 따른 서브쿼리 분류
  Un-Correlated(비연관) : 서브쿼리가 메인쿼리 컬럼을 가지고 있지 않는 형태의 서브쿼리이다.
          메인쿼리에 값(서브쿼리가 실행된 결과)를 제공하기 위한 목적으로  주로 사용한다.
  Correlated(연관) : 서브쿼리가 메인쿼리 칼럼을 가지고 있는 형태의 서브쿼리이다.
          일반적으로 메인쿼리가 먼저 수행되어 읽혀진 데이터를 서브쿼리에서 조건이 맞는지 확인
	  하고자 할 때 주로 사용된다.  (EXISTS서브쿼리는 항상 연관 서브쿼리로 사용된다. 조건을 만족하는 1건만 찾으면
	  추가 검색을 하지 않는다.)
2 반환되는 데이터의 형태에 따른 서브쿼리 종류
  Single Row(단일행 서브쿼리) : 서브쿼리의 실행결과가 항상 1건 이하인 서브쿼리를 의미한다. 
          단일행 서브쿼리는 단일 행 비교 연산자와 함께 사용된다.
	  단일 행 비교 연산자는 =, <, <=, >, >=, <>이 있다.
  Multi Row(다중행 서브쿼리) : 서브쿼리의 실행 결과가 여러 건인 서브쿼리를 의미한다. 
          다중 행 서브쿼리는 다중 행 비교 연산자와 함께 사용된다. 
	  다중 행 비교 연산자에는 in, all, any, some, exists가 있다.
	      in : 메인쿼리의 비교조건('='연산자로 비교할 경우)이 서브쿼리의 결과 중에서
               하나라도 일치하면 참이다.
           any,some : 메인 쿼리의 비교 조건이 서브 쿼리의 검색 결과와 하나 이상이 일치하면
                참이다.
           all : 메인 쿼리의 비교 조건이 서브 쿼리의 검색 결과와 모든 값이 일치하면 참이다.
           exists : 메인 쿼리의 비교 조건이 서브 쿼리의 결과 중에서 만족하는 값이 하나라도
               존재하면 참이다.
  Multi Column(다중칼럼 서브쿼리) : 서브쿼리의 실행 결과로 여러 컬럼을 반환한다.
          메인쿼리의 조건절에 여러 컬럼을 동시에 비교할 수 있다. 
	  서브쿼리와 메인쿼리에서 비교하고자 하는 컬럼 갯수와 컬럼의 위치가 동일해야 한다.
https://www.w3resource.com/sql/subqueries/correlated-subqueries-using-aliases.php	  
--------------------------------------------------------------------------------- */ 

--90번 부서에 근무하는 LEX의 부서명을 출력하시오.
SELECT department_name
FROM departments
WHERE department_id=90;

-- LEXT가 근무하는 부서명을 출력하시오
SELECT department_id
FROM employees
WHERE first_name='Lex';

SELECT department_name
FROM departments
WHERE department_id=90;

SELECT d.department_name , e.first_name
FROM employees e , departments d
WHERE e.department_id = d.department_id AND e.first_name='Lex';

--해당조건에 따라나온 결과값에 = 서브커리( 결과값에 해당하는 조건을 찾아내라)
-- =(등가교환 식으로) 결과값이 무조건 하나만 나와야한다.
SELECT department_name
FROM departments
WHERE department_id = (SELECT department_id
                       FROM employees
                       WHERE first_name='Lex'
                       );

/*
[실행순서]
1.서브쿼리 실행
SELECT department_id
FROM employees
WHERE first_name='Lex'

2. 메인쿼리의 FROM 절
FROM departments

3. 메인쿼리의 WHERE 절
WHERE department_id = 90

4.메인쿼리의 SELECT절
SELECT department_name
*/

--'Lex'와 동일한 업무(job_id)를 가진 사원의 이름(first_name), 
 -- 업무명(job_title), 입사일(hire_date)을 출력하시오.   
SELECT e.first_name, j.job_id , e.hire_date
FROM employees e, jobs j
WHERE e.job_id=j.job_id
AND e.job_id = (
                SELECT job_id
                FROM employees
                WHERE first_name = 'Lex'
                );
                
-- 'IT'에 근무하는 사원이름(first_name), 부서번호을 출력하시오. 
SELECT e.first_name, d.department_id --사원 이름을 찾으시오
FROM employees e , departments d
WHERE e.department_id = (
                         SELECT department_id -- 부서번호가
                         FROM departments -- 부서 부분에서
                         WHERE department_name='IT' -- IT일때
                         );
                         
--'Bruce'보다 급여를 많이 받은 사원이름(first_name), 부서명, 급여를 출력하시오.
SELECT e.first_name, d.department_name, e.salary
FROM employees e , departments d
WHERE e.department_id = d.department_id
AND e.salary > (
                SELECT salary
                FROM employees
                WHERE first_name = 'Bruce'
                )
ORDER BY e.salary ASC;

--Steven와 같은 부서에서 근무하는 사원의 이름, 급여, 입사일을 출력하시오.(in)
SELECT department_id
FROM employees
WHERE first_name='Steven';/* 2row이므로 IN 연산자를 사용해서 서브쿼리를 작성해야 한다.*/

SELECT first_name, salary, hire_date,department_id
FROM employees
WHERE department_id IN(
                        SELECT department_id
                        FROM employees
                        WHERE first_name='Steven'
                        ); 
                        
--부서별로 가장 급여를 많이 받는 사원이름, 부서번호, 급여를 출력하시오.(in)
SELECT department_id, max(salary)
FROM employees
GROUP BY department_id;

SELECT first_name, department_id ,salary
FROM employees
WHERE (department_id,salary) IN (SELECT department_id, max(salary)
                               FROM employees
                               GROUP BY department_id
                               );
                               
--부서명에 IT가 포함이된 사람이 속한 사원명(first_name), 
--부서번호(department_id), 부서명(department_name)을 출력하시오.(in)
SELECT department_name
                            FROM departments
                            WHERE department_name LIKE '%IT%';
                            
SELECT e.first_name , d.department_id, d.department_name
FROM employees e , departments d
WHERE e.department_id = d.department_id
AND d.department_name IN (SELECT department_name
                            FROM departments
                            WHERE department_name LIKE '%IT%');
                            
--30소속된 사원들 중에서 급여를 가장 받은 사원보다 더 많은 급여를 받는
--사원이름, 급여, 입사일을 출력하시오. (ALL)
--(서브쿼리에서 max()함수를 사용하지 않는다);
SELECT first_name, salary , hire_date, department_id
FROM employees
WHERE salary > ALL (SELECT salary
                    FROM employees
                    WHERE department_id=30); --ALL은 30부서에서 가장 높은 급여 위로

 --30소속된 사원들이 받은 급여보다  높은 급여를 받는 
--사원이름, 급여, 입사일을 출력하시오. (ANY)
--(서브쿼리에서 min()함수를 사용하지 않는다);
SELECT first_name, salary , hire_date , department_id
FROM employees
WHERE salary > ANY (SELECT salary
                    FROM employees
                    WHERE department_id=30 --ANY는 30부서까지 포함
                    )
AND department_id != 30;

  --Toronto 도시에 근무하는 사원들이 받는 최소급여보다 많이 받는  사원의
--first_name, city, salary을 출력하시오(ANY)
--Toronto은 제외한다.
SELECT e.first_name , l.city, e.salary
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id
AND d.location_id = l.location_id
AND e.salary > ANY (SELECT e.salary
                    FROM employees e, departments d, locations l
                    WHERE e.department_id=d.department_id
                    AND d.location_id = l.location_id
                    AND l.city = 'Toronto'
                    )
AND l.city <> 'Totonto';

SELECT e.first_name, l.city, e.salary
FROM employees e, departments d, locations l
WHERE e.department_id=d.department_id
AND d.location_id=l.location_id
AND e.salary  > ANY ( SELECT e.salary
                      FROM employees e, departments d, locations l
                      WHERE e.department_id=d.department_id
                      AND d.location_id=l.location_id
                      AND l.city='Toronto'
                     )
AND l.city <> 'Toronto';

/*-----------------------------------------------------
 상관관계 서브쿼리
 : 서브쿼리에서 메인쿼리의 컬럼을 참조한다.(메인쿼리를 먼저수행한다.)
   서브쿼리는 메인쿼리 각각의 행에 대해서 순서적으로 한번씩 실행한다.
 <아래 쿼리 처리순서>
 1st : 바깥쪽 쿼리의 첫째 row에 대하여 
 2nd : 안쪽 쿼리에서 자신의 속해있는 부서의 MAX salary과
       비교하여 true 이면 바깥의 컬럼값을 반환하고 , 
       false 이면 값을 버린다. 
 3rd : 바깥쪽 쿼리의 두 번째 row에 대하여 마찬가지로 실행하며, 
       이렇게 바깥쪽 쿼리의 마지막 row까지 실행한다. 
	   
https://www.w3resource.com/sql/subqueries/correlated-subqueries-using-aliases.php	   
----------------------------------------------------*/

--사원이 있는 부서만 출력하시오.
SELECT department_id, department_name
FROM departments;

--비상관관계 서브쿼리 : 서브쿼리에서 메인쿼리의 컬럼을 참조하지 않음
SELECT department_id, department_name
FROM departments
WHERE department_id IN (
                        SELECT department_id
                        FROM employees
                        WHERE department_id IS NOT NULL
                        GROUP BY department_id 
                        );
                        
-- 상관관계 서브쿼리 : 서브쿼리에서 메인쿼리의 컬럼을 참조함
/* 6*/SELECT department_id, department_name
/* 1*/FROM departments d
/* 5*/WHERE department_id IN (
/* 4*/                    SELECT department_id -- 메인쿼리의 FROM값이 일치하면 TRUE, 불일치면 FALSE , TRUE값만 출력, FALSE는 제거
/* 2*/                    FROM employees
/* 3*/                    WHERE department_id = d.department_id
                        );
            
-- 위에식과 같은 값            
-- EXISTS 서브쿼리 작동방식
     ①EXISTS는 서브쿼리 결과가 1행이라도 존재하는지만 체크합니다.
     ②실제 반환값(여기선 SELECT 1)은 중요하지 않습니다.
     ③ 성능상 이점도 있음 → 조건을 만족하는 첫 번째 행을 찾는 즉시 종료
  SELECT department_id, department_name
  FROM departments d
   WHERE  EXISTS (
                  SELECT 1 -- 상관관계에서는 어떤값을 넣어도 상관이없다.
                  FROM employees -- TRUE값만 메인쿼리의 SELECT로 나타난다. FLASE는 값 출력X
                  WHERE department_id   = d.department_id                                      
                  )
   ORDER BY department_id;     
 
 /*
 1. FROM departments d
    |
   ↓
2. 각 부서 d에 대해 다음 서브쿼리 실행:
     EXISTS (
        SELECT 1
        FROM employees e
        WHERE e.department_id = d.department_id
     )
   → 부서에 속한 직원이 있으면 TRUE
    |
   ↓
3. WHERE 절을 만족하는 부서만 남김
    |
   ↓
4. SELECT department_id, department_name 출력
    |
   ↓
5.  ORDER BY department_id;   출력
 */

--사원이 없는 부서만 출력
 SELECT department_id, department_name
  FROM departments d
   WHERE NOT EXISTS (
                  SELECT 1 -- 상관관계에서는 어떤값을 넣어도 상관이없다.
                  FROM employees -- TRUE값만 메인쿼리의 SELECT로 나타난다. FLASE는 값 출력X
                  WHERE department_id   = d.department_id                                      
                  )
   ORDER BY department_id;   
   
--부서가 있는 사원의 정보를 출력하시오
SELECT employee_id, first_name, department_id
FROM employees e
WHERE EXISTS (
              SELECT 1
              FROM departments
              WHERE department_id = e.department_id
              );

--부서를 배정받지 못한 사원의 정보를 출력하시오
SELECT employee_id, first_name, department_id
FROM employees e
WHERE NOT EXISTS (
              SELECT 1
              FROM departments
              WHERE department_id = e.department_id
              );
-- 관리자가 있는 사원의 정보를 출력하시오
SELECT employee_id, first_name , department_id
FROM employees w
WHERE EXISTS (
              SELECT 1
              FROM employees m --구분을 하기 위해서 m으로 나눔
              WHERE m.employee_id = w.manager_id
              ); 
              
 -- 관리자가 없는 사원의 정보를 출력하시오
SELECT employee_id, first_name , department_id
FROM employees w
WHERE NOT EXISTS (
              SELECT 1
              FROM employees m --구분을 하기 위해서 m으로 나눔
              WHERE m.employee_id = w.manager_id
              ); 
              
/*=========================================================
Top-N 서브쿼리 (작다, 작거나 같다)페이징 처리할때 주로 사용
   상위의 값을 추출할때 사용된다.
   <, <=연산자를 사용할수 있다. 단 비교되는 값이 1일때는 =도 가능하다.
   order by절을 사용할 수 있다.
=========================================================*/
--급여가 가장 높은 상위 3명을 검색하시오.
SELECT rownum, emp.*-- emp.first_name, emp.salary
FROM (
      SELECT first_name, salary
      FROM employees 
      ORDER BY salary DESC /* FROM절에서 사용된 서브쿼리를 iniline view(인라인뷰)라고 한다.*/ 
)emp
WHERE rownum <= 3;

--급여가 가장 높은 상위 4위부터 8위까지 검색하시오.,
SELECT trow.*
FROM ( 
      SELECT rownum AS rm, emp.*
      FROM (
            SELECT first_name, salary      
            FROM employees
            ORDER BY salary DESC
            )emp
      )trow
WHERE   trow.rm >= 4 AND trow.rm <= 8;

--월 별 입사자 수를 조회하되 입사자수가 가장 많은 상위 3개만 출력되도록 하시오.
--  <출력:   월     입사자수 >
SELECT emp.*
FROM(
SELECT to_char(hire_date,'mm'), count(*)
FROM employees
GROUP BY to_char(hire_date,'mm')
ORDER BY count(*) DESC
)emp
WHERE rownum <= 3;

/*-----------------------------------------------------------
       문제
 -------------------------------------------------------------*/
--1) department_id가 60인 부서의 도시명을 알아내는 SELECT문장을 기술하시오
SELECT d.department_id , d.department_name , l.city
FROM departments d , locations l
WHERE d.location_id = l.location_id 
AND department_id= 60;
------------------------------------------------------------------------------
--같은 값 위에는 조인 아래는 서브쿼리
SELECT city
FROM locations
WHERE location_id = ( SELECT location_id
                      FROM departments
                      WHERE department_id=60);

------------------------------------------------------------------------------    
--2)사번이 107인 사원과 부서가같고,167번의 급여보다 많은 사원들의 사번,이름(first_name),급여를 출력하시오.
SELECT first_name , employee_id , salary 
FROM employees 
WHERE department_id = ( 
                SELECT department_id
                FROM employees
                WHERE employee_id=107
                )
AND salary > (SELECT salary
              FROM employees
              WHERE employee_id = 167);
------------------------------------------------------------------------------
SELECT employee_id, first_name, salary
FROM employees
WHERE department_id = (SELECT  department_id
                       FROM employees
                       WHERE employee_id = 107)
 AND salary > (SELECT salary
              FROM employees
              WHERE employee_id = 167);
--WHERE department_id=60
-- AND salary > 6200;

--3) 급여평균보다 급여를 적게받는 사원들중 커미션을 받는 사원들의 사번,이름(first_name),급여,커미션 퍼센트를 출력하시오.
SELECT employee_id, first_name, salary, commission_pct
FROM employees
WHERE salary < (SELECT avg(salary)
                FROM employees
                )
AND commission_pct IS NOT NULL;
    
-4)각 부서의 최소급여가 20번 부서의 최소급여보다 많은 부서의 번호와 그 부서의 최소급여를 출력하시오.
SELECT department_id, min(salary)
FROM employees
GROUP BY department_id
HAVING min(salary) > (SELECT min(salary)
                      FROM employees
                      GROUP BY department_id
                      HAVING department_id = 20)
--HAVING min(salary) >ANY ( SELECT salary
--                          FROM employees
--                          WHERE department_id = 20)
ORDER BY  department_id;
 
  
--5) 사원번호가 177인 사원과 담당 업무가 같은 사원의 사원이름(first_name)과 담당업무(job_id)하시오.   
SELECT first_name, job_id
FROM employees
WHERE job_id = (SELECT job_id
                FROM employees
                WHERE employee_id = 177);
 
--6) 최소 급여를 받는 사원의 이름(first_name), 담당 업무(job_id) 및 급여(salary)를 표시하시오(그룹함수 사용).
SELECT first_name, job_id, salary
FROM employees
WHERE salary = (SELECT min(salary)
                FROM employees);
				
--7)업무별 평균 급여가 가장 적은  업무(job_id)를 찾아 업무(job_id)와 평균 급여를 표시하시오.
SELECT job_id, avg(salary)
FROM employees
GROUP BY job_id
HAVING avg(salary) = (SELECT min(avg(salary))
                      FROM employees
                      GROUP BY job_id);

					  
--8) 각 부서의 최소 급여를 받는 사원의 이름(first_name), 급여(salary), 부서번호(department_id)를 표시하시오.
SELECT first_name, salary, department_id
FROM employees
WHERE (department_id, salary) IN (SELECT department_id, min(salary)
                                  FROM employees
                                  GROUP BY department_id)
ORDER BY department_id;


SELECT first_name, salary, department_id
FROM employees e1
WHERE  salary = (SELECT  min(salary)
                 FROM employees e2
                 WHERE e1.department_id=e2.department_id)
ORDER BY department_id;

--9)담당 업무가 프로그래머(IT_PROG)인 모든 사원보다 급여가 적으면서 
--업무가 프로그래머(IT_PROG)가 아닌  사원들의 사원번호(employee_id), 이름(first_name), 
--담당 업무(job_id), 급여(salary))를 출력하시오.
SELECT employee_id, first_name, job_id, salary
FROM employees
WHERE salary <ALL (SELECT salary
                   FROM employees
                   WHERE job_id = 'IT_PROG')
 AND job_id <> 'IT_PROG';                  

--10)부하직원이 없는 모든 사원의 이름을 표시하시오.
SELECT employee_id, first_name
FROM employees
WHERE employee_id NOT IN (SELECT e.employee_id
                          FROM employees e, employees m
                          WHERE e.employee_id=m.manager_id)
ORDER BY employee_id;


SELECT employee_id, first_name
FROM employees e
WHERE NOT EXISTS (SELECT employee_id
                  FROM employees m
                  WHERE m.manager_id = e.employee_id)
ORDER BY employee_id;


