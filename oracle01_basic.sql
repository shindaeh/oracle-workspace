 DESC employees;
select first_name from employees;
 SELECT *  FROM tab;
 SELECT salary,salary*10 AS " b o n u s "
 From employees;
 
SELECT last_name || '님의 급여는' || salary ||  '입니다.' AS name
FROM employees;
 
-- employees테이블에서 salary이 3000미만일때의
-- first_name, salary을 출력하라.
SELECT first_name, salary
FROM employees
WHERE salary < 3000;


-- employees테이블에서 first_name컬럼의 값이 'David' 일때의
-- first_name, salary을 출력하라.
SELECT first_name, salary
FROM employees
WHERE first_name='David';

-- employees테이블에서 first_name컬럼의 값이 'David' 아닐때의
-- first_name, salary을 출력하라.
SELECT first_name, salary
FROM employees
WHERE first_name <> 'David';

-- &&(and), ||(or) - ,(쉼표)쓰는 순간 문자로 입력된다.
-- employees테이블에서 salary이 3000, 9000, 17000일때
-- first_name, hire_date, salary을 출력하라.
SELECT first_name, hire_date, salary
FROM employees
WHERE salary=3000 OR salary=9000 OR salary=17000;

SELECT first_name, hire_date, salary
FROM employees
WHERE salary IN(3000,9000,17000);

-- employees테이블에서 salary이 3000부터 5000까지 일때의
-- first_name, hire_date, salary을 출력하라
SELECT first_name, hire_date, salary
FROM employees
WHERE salary >= 3000 AND salary <= 5000;

SELECT first_name, hire_date, salary
FROM employees
WHERE salary BETWEEN 3000 AND 5000;

--employees테이블에서 job_id가 'IT_PROG'이 아닐때
--first_name, email, job_id을 출력하라.
SELECT first_name, email, job_id
FROM employees
WHERE job_id != 'IT_TROG'; 
SELECT first_name, email, job_id
FROM employees
WHERE job_id ^= 'IT_TROG';

SELECT first_name, email, job_id
FROM employees
WHERE NOT (job_id = 'IT_TROG');

--employees테이블에서 salary이 3000, 9000, 17000이 아닐때의
--first_name, hire_date, salary을 출력하라
SELECT first_name, hire_date, salary
FROM employees
WHERE NOT salary=3000 OR salary=9000 OR salary=17000;

SELECT first_name, hire_date, salary
FROM employees
WHERE salary NOT IN(3000,9000,17000);

-- employees테이블에서 salary이 3000부터 5000까지 일때의
-- first_name, hire_date, salary을 출력하라
SELECT first_name, hire_date, salary
FROM employees
WHERE NOT salary >= 3000 AND salary <= 5000;

SELECT first_name, hire_date, salary
FROM employees
WHERE NOT salary BETWEEN 3000 AND 5000;

--employees테이블에서 commission_pct이 null일때
--first_name, salary, commission_pct을 출력하라.
SELECT first_name, salary, commission_pct
FROM employees
WHERE  commission_pct IS NULL;

--employees테이블에서 commission_pct이 null이 아닐때
--first_name, salary, commission_pct을 출력하라.
SELECT first_name, salary, commission_pct
FROM employees
WHERE  commission_pct IS NOT NULL;

-- employees테이블에서 first_name에 'der'이 포함이된
-- first_name, salary, email을 출력하라.
SELECT first_name, salary, commission_pct
FROM employees
WHERE first_name LIKE '%der%';
--%가 앞에있으면 끝나는, %가 뒤에있으면 시작하는 , % % 면 포함되어있는

-- employees테이블에서 first_name에 'der'이 포함이된
-- first_name, salary, email을 출력하라.
SELECT first_name, salary, commission_pct
FROM employees
WHERE first_name NOT LIKE '%der%';

--employees테이블에서 first_name의 값중 'A'로 시작하고
--두번째 문자는 임의 문자이면 'exander'로 끝나는
--first_name, salary, email을 출력하라.
SELECT first_name, salary, email
FROM employees
WHERE first_name LIKE 'A_exander'; -- _언더바):임의문자 1개

-- 1) employees테이블에서 급여가 17000이하인 사원의 사원번호, 사원명(first_name), 급여를 출력하시오.
SELECT employee_id, first_name, salary
FROM employees
WHERE  salary <= 17000;

--2) employees테이블에서 2005년 1월 1일 이후에 입사한 사원을 출력하시오.
SELECT hire_date, salary
FROM employees
WHERE hire_date >= '2005-01-01';

--3) employees테이블에서 급여가 5000이상이고 업무(job_id)이 'IT_PROG'이 사원의 사원명(first_name), 급여, 
--   업무을 출력하시오.
SELECT job_id,salary,first_name
FROM employees
WHERE salary <= 5000 AND job_id = 'IT_PROG';

--4) employees테이블에서 부서번호가 10, 40, 50 인 사원의 사원명(first_name), 부서번호, 이메일(email)을 출력하시오.
SELECT first_name,email,DEPARTMENT_ID
FROM employees
WHERE DEPARTMENT_ID IN(10,40,50);

--5) employees테이블에서 사원명(first_name)이 even이 포함된 사원명,급여,입사일을 출력하시오.
SELECT first_name,salary,hire_date
FROM employees
WHERE first_name LIKE '%even%';

--6) employees테이블에서 사원명(first_name)이 teve앞뒤에 문자가 하나씩 있는 사원명,급여,입사일을 출력하시오.
SELECT first_name,salary,hire_date
FROM employees
WHERE first_name Like '_teve_';

--7) employees테이블에서 급여가 17000이하이고 커미션이 null이 아닐때의 사원명(first_name), 급여, 
--  커미션을 출력하시오.
SELECT salary,commission_pct,first_name
FROM employees
WHERE salary <= 17000 AND commission_pct IS NOT NULL;

--8) 2005년도에 입사한 사원의 사원명(first_name),입사일을 출력하시오.
SELECT first_name,hire_date
FROM employees
WHERE to_char(hire_date, 'yyyy')='2005';

--9) 커미션 지급 대상인 사원의 사원명(first_name), 커미션을 출력하시오.
SELECT first_name, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL;

--10) 사번이 206인 사원의 이름(first_name)과 급여를 출력하시오.
SELECT employee_id, first_name, salary
FROM employees 
WHERE employee_id = '206';

--11) 급여가 3000이 넘는 업무(job_id),급여(salary)를 출력하시오.
SELECT job_id, salary
FROM employees 
WHERE salary > 3000;

--12)'ST_MAN'업무을 제외한 사원들의 사원명(first_name)과 업무(job_id)을 출력하시오.
SELECT first_name,job_id
FROM employees
WHERE job_id != 'ST_MAN';

--13) 업무이 'PU_CLERK' 인 사원 중에서 급여가 10000 이상인 사원명(first_name),업무(job_id),급여(salary)을 출력하시오.
SELECT first_name,salary,salary
FROM employees
WHERE job_id = 'PU_CLERK' AND salary >= 10000;

--14) commission을 받는 사원명(first_name)을 출력하시오.
SELECT first_name
FROM employees
WHERE commission_pct IS NOT NULL;

--15) 20번 부서와 30번 부서에 속한 사원의 사원명(fist_name), 부서를 출력하시오.
SELECT first_name, department_id
FROM employees
WHERE department_id IN(20,30);

--16) 급여가 많은 사원부터 출력하되 급여가 같은 경우 사원명(first_name) 순서대로 출력하시오.
SELECT *
FROM employees
ORDER BY salary DESC, first_name ASC; -- DESCENDING(내림차순),ASCENDING(오름차순)

--17) 업무이 'MAN' 끝나는 사원의 사원명(first_name), 급여(salary), 업무(job_id)을 출력하시오.
SELECT job_id,salary,first_name
FROM employees
WHERE job_id LIKE '%MAN';

--========================================================================================
--union(합집합) -중복 제거
SELECT department_id, first_name, last_name
FROM employees
WHERE department_id = 20 OR department_id = 40
UNION
SELECT department_id, first_name, last_name
FROM employees
WHERE department_id = 20 OR department_id = 60;

--union all(합집합) 중복 제거 미적용
SELECT department_id, first_name, last_name
FROM employees
WHERE department_id = 20 OR department_id = 40
UNION ALL
SELECT department_id, first_name, last_name
FROM employees
WHERE department_id = 20 OR department_id = 60;

-- intersect(교집합) - 이것도 중복제거됨
SELECT department_id, first_name, last_name
FROM employees
WHERE department_id = 20 OR department_id = 40
INTERSECT
SELECT department_id, first_name, last_name
FROM employees
WHERE department_id = 20 OR department_id = 60;

-- MINUS(차집합) - a,b포함해서 중복되는 값 + b의 값 전부 제거
SELECT department_id, first_name, last_name
FROM employees
WHERE department_id = 20 OR department_id = 40
MINUS
SELECT department_id, first_name, last_name
FROM employees
WHERE department_id = 20 OR department_id = 60;