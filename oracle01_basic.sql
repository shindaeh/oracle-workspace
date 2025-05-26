 DESC employees;
select first_name from employees;
 SELECT *  FROM tab;
 SELECT salary,salary*10 AS " b o n u s "
 From employees;
 
SELECT last_name || '���� �޿���' || salary ||  '�Դϴ�.' AS name
FROM employees;
 
-- employees���̺��� salary�� 3000�̸��϶���
-- first_name, salary�� ����϶�.
SELECT first_name, salary
FROM employees
WHERE salary < 3000;


-- employees���̺��� first_name�÷��� ���� 'David' �϶���
-- first_name, salary�� ����϶�.
SELECT first_name, salary
FROM employees
WHERE first_name='David';

-- employees���̺��� first_name�÷��� ���� 'David' �ƴҶ���
-- first_name, salary�� ����϶�.
SELECT first_name, salary
FROM employees
WHERE first_name <> 'David';

-- &&(and), ||(or) - ,(��ǥ)���� ���� ���ڷ� �Էµȴ�.
-- employees���̺��� salary�� 3000, 9000, 17000�϶�
-- first_name, hire_date, salary�� ����϶�.
SELECT first_name, hire_date, salary
FROM employees
WHERE salary=3000 OR salary=9000 OR salary=17000;

SELECT first_name, hire_date, salary
FROM employees
WHERE salary IN(3000,9000,17000);

-- employees���̺��� salary�� 3000���� 5000���� �϶���
-- first_name, hire_date, salary�� ����϶�
SELECT first_name, hire_date, salary
FROM employees
WHERE salary >= 3000 AND salary <= 5000;

SELECT first_name, hire_date, salary
FROM employees
WHERE salary BETWEEN 3000 AND 5000;

--employees���̺��� job_id�� 'IT_PROG'�� �ƴҶ�
--first_name, email, job_id�� ����϶�.
SELECT first_name, email, job_id
FROM employees
WHERE job_id != 'IT_TROG'; 
SELECT first_name, email, job_id
FROM employees
WHERE job_id ^= 'IT_TROG';

SELECT first_name, email, job_id
FROM employees
WHERE NOT (job_id = 'IT_TROG');

--employees���̺��� salary�� 3000, 9000, 17000�� �ƴҶ���
--first_name, hire_date, salary�� ����϶�
SELECT first_name, hire_date, salary
FROM employees
WHERE NOT salary=3000 OR salary=9000 OR salary=17000;

SELECT first_name, hire_date, salary
FROM employees
WHERE salary NOT IN(3000,9000,17000);

-- employees���̺��� salary�� 3000���� 5000���� �϶���
-- first_name, hire_date, salary�� ����϶�
SELECT first_name, hire_date, salary
FROM employees
WHERE NOT salary >= 3000 AND salary <= 5000;

SELECT first_name, hire_date, salary
FROM employees
WHERE NOT salary BETWEEN 3000 AND 5000;

--employees���̺��� commission_pct�� null�϶�
--first_name, salary, commission_pct�� ����϶�.
SELECT first_name, salary, commission_pct
FROM employees
WHERE  commission_pct IS NULL;

--employees���̺��� commission_pct�� null�� �ƴҶ�
--first_name, salary, commission_pct�� ����϶�.
SELECT first_name, salary, commission_pct
FROM employees
WHERE  commission_pct IS NOT NULL;

-- employees���̺��� first_name�� 'der'�� �����̵�
-- first_name, salary, email�� ����϶�.
SELECT first_name, salary, commission_pct
FROM employees
WHERE first_name LIKE '%der%';
--%�� �տ������� ������, %�� �ڿ������� �����ϴ� , % % �� ���ԵǾ��ִ�

-- employees���̺��� first_name�� 'der'�� �����̵�
-- first_name, salary, email�� ����϶�.
SELECT first_name, salary, commission_pct
FROM employees
WHERE first_name NOT LIKE '%der%';

--employees���̺��� first_name�� ���� 'A'�� �����ϰ�
--�ι�° ���ڴ� ���� �����̸� 'exander'�� ������
--first_name, salary, email�� ����϶�.
SELECT first_name, salary, email
FROM employees
WHERE first_name LIKE 'A_exander'; -- _�����):���ǹ��� 1��

-- 1) employees���̺��� �޿��� 17000������ ����� �����ȣ, �����(first_name), �޿��� ����Ͻÿ�.
SELECT employee_id, first_name, salary
FROM employees
WHERE  salary <= 17000;

--2) employees���̺��� 2005�� 1�� 1�� ���Ŀ� �Ի��� ����� ����Ͻÿ�.
SELECT hire_date, salary
FROM employees
WHERE hire_date >= '2005-01-01';

--3) employees���̺��� �޿��� 5000�̻��̰� ����(job_id)�� 'IT_PROG'�� ����� �����(first_name), �޿�, 
--   ������ ����Ͻÿ�.
SELECT job_id,salary,first_name
FROM employees
WHERE salary <= 5000 AND job_id = 'IT_PROG';

--4) employees���̺��� �μ���ȣ�� 10, 40, 50 �� ����� �����(first_name), �μ���ȣ, �̸���(email)�� ����Ͻÿ�.
SELECT first_name,email,DEPARTMENT_ID
FROM employees
WHERE DEPARTMENT_ID IN(10,40,50);

--5) employees���̺��� �����(first_name)�� even�� ���Ե� �����,�޿�,�Ի����� ����Ͻÿ�.
SELECT first_name,salary,hire_date
FROM employees
WHERE first_name LIKE '%even%';

--6) employees���̺��� �����(first_name)�� teve�յڿ� ���ڰ� �ϳ��� �ִ� �����,�޿�,�Ի����� ����Ͻÿ�.
SELECT first_name,salary,hire_date
FROM employees
WHERE first_name Like '_teve_';

--7) employees���̺��� �޿��� 17000�����̰� Ŀ�̼��� null�� �ƴҶ��� �����(first_name), �޿�, 
--  Ŀ�̼��� ����Ͻÿ�.
SELECT salary,commission_pct,first_name
FROM employees
WHERE salary <= 17000 AND commission_pct IS NOT NULL;

--8) 2005�⵵�� �Ի��� ����� �����(first_name),�Ի����� ����Ͻÿ�.
SELECT first_name,hire_date
FROM employees
WHERE to_char(hire_date, 'yyyy')='2005';

--9) Ŀ�̼� ���� ����� ����� �����(first_name), Ŀ�̼��� ����Ͻÿ�.
SELECT first_name, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL;

--10) ����� 206�� ����� �̸�(first_name)�� �޿��� ����Ͻÿ�.
SELECT employee_id, first_name, salary
FROM employees 
WHERE employee_id = '206';

--11) �޿��� 3000�� �Ѵ� ����(job_id),�޿�(salary)�� ����Ͻÿ�.
SELECT job_id, salary
FROM employees 
WHERE salary > 3000;

--12)'ST_MAN'������ ������ ������� �����(first_name)�� ����(job_id)�� ����Ͻÿ�.
SELECT first_name,job_id
FROM employees
WHERE job_id != 'ST_MAN';

--13) ������ 'PU_CLERK' �� ��� �߿��� �޿��� 10000 �̻��� �����(first_name),����(job_id),�޿�(salary)�� ����Ͻÿ�.
SELECT first_name,salary,salary
FROM employees
WHERE job_id = 'PU_CLERK' AND salary >= 10000;

--14) commission�� �޴� �����(first_name)�� ����Ͻÿ�.
SELECT first_name
FROM employees
WHERE commission_pct IS NOT NULL;

--15) 20�� �μ��� 30�� �μ��� ���� ����� �����(fist_name), �μ��� ����Ͻÿ�.
SELECT first_name, department_id
FROM employees
WHERE department_id IN(20,30);

--16) �޿��� ���� ������� ����ϵ� �޿��� ���� ��� �����(first_name) ������� ����Ͻÿ�.
SELECT *
FROM employees
ORDER BY salary DESC, first_name ASC; -- DESCENDING(��������),ASCENDING(��������)

--17) ������ 'MAN' ������ ����� �����(first_name), �޿�(salary), ����(job_id)�� ����Ͻÿ�.
SELECT job_id,salary,first_name
FROM employees
WHERE job_id LIKE '%MAN';

--========================================================================================
--union(������) -�ߺ� ����
SELECT department_id, first_name, last_name
FROM employees
WHERE department_id = 20 OR department_id = 40
UNION
SELECT department_id, first_name, last_name
FROM employees
WHERE department_id = 20 OR department_id = 60;

--union all(������) �ߺ� ���� ������
SELECT department_id, first_name, last_name
FROM employees
WHERE department_id = 20 OR department_id = 40
UNION ALL
SELECT department_id, first_name, last_name
FROM employees
WHERE department_id = 20 OR department_id = 60;

-- intersect(������) - �̰͵� �ߺ����ŵ�
SELECT department_id, first_name, last_name
FROM employees
WHERE department_id = 20 OR department_id = 40
INTERSECT
SELECT department_id, first_name, last_name
FROM employees
WHERE department_id = 20 OR department_id = 60;

-- MINUS(������) - a,b�����ؼ� �ߺ��Ǵ� �� + b�� �� ���� ����
SELECT department_id, first_name, last_name
FROM employees
WHERE department_id = 20 OR department_id = 40
MINUS
SELECT department_id, first_name, last_name
FROM employees
WHERE department_id = 20 OR department_id = 60;