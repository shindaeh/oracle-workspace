 DESC employees;
select first_name from employees;
 SELECT *  FROM tab;
 SELECT salary,salary*10 AS " b o n u s "
 From employees;
 
SELECT last_name || '���� �޿���' || salary ||  '�Դϴ�.' AS name
FROM employees;
 
? employees���̺��� salary�� 3000�̸��϶���
? first_name, salary�� ����϶�.
SELECT first_name, salary
FROM employees
WHERE salary < 3000;


? employees���̺��� first_name�÷��� ���� 'David' �϶���
? first_name, salary�� ����϶�.
SELECT first_name, salary
FROM employees
WHERE first_name='David';

? employees���̺��� first_name�÷��� ���� 'David' �ƴҶ���
? first_name, salary�� ����϶�.
SELECT first_name, salary
FROM employees
WHERE first_name <> 'David';

-- &&(and), ||(or) - ,(��ǥ)���� ���� ���ڷ� �Էµȴ�.
--employees���̺��� salary�� 3000, 9000, 17000�϶�
--first_name, hire_date, salary�� ����϶�.
SELECT first_name, hire_date, salary
FROM employees
WHERE salary=3000 OR salary=9000 OR salary=17000;

SELECT first_name, hire_date, salary
FROM employees
WHERE salary IN(3000,9000,17000);