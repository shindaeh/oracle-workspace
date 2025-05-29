/*===============================
���̺� ���� ����
CREATE TABLE table_name(
  column_name datatype,
  column_name datatype
);

�ڷ���(datatype)
varchar2 - �������� ���ڸ� ����
char - �������� ���ڸ� ����
number(m)-��������
number(m,n)- �Ǽ�����
date - ��¥ ����
===============================*/
CREATE TABLE student(
  name varchar2(20), --����Ʈ(����,Ư������- 1byte / �ѱ�-3byte)
  age number(3),   --�ڸ���
  avg number(5,2), --5�� ��ü�ڸ���, 2�� �Ҽ��� �ڸ���
  hire date  
);

--�������
INSERT INTO student(name,age,avg,hire)
VALUES('ȫ�浿', 30, 97.85, sysdate);

SELECT*FROM student;
--����:20����Ʈ �ʰ� 
--RA-12899: value too large for column "HR"."STUDENT"."NAME" (actual: 26, maximum: 20)
INSERT INTO student(name,age,avg,hire)
VALUES('������ ���� ����', 30, 97.85, sysdate);

--����:3�ڸ������� ���� - 0~999�� �ش�
--ORA-01438: value larger than specified precision allowed for this column
INSERT INTO student(name,age,avg,hire)
VALUES('ȫ�浿', 3000, 97.85, sysdate);
--����:�Ҽ����� ��ü�ڸ��� ���� X 2�Ҽ��� �ڸ��� �ѱ� ������ �����߻�
--ORA-01438: value larger than specified precision allowed for this column
INSERT INTO student(name,age,avg,hire)
VALUES('ȫ�浿', 30, 993.1385, sysdate);

SELECT*FROM student;
--����:�����ڸ���5���� �Ҽ��ڸ��� 2 �̱� ������ �����߻�
--ORA-01438: value larger than specified precision allowed for this colum
INSERT INTO student(name,age,avg,hire)
VALUES('ȫ�浿', 30, 9731.8, sysdate);

SELECT*FROM student;
/*====================================
ALTER 
 ��ü(���̺�)�� ������ �������ִ� ��ɾ��̴�.
======================================*/
--���� : CREATE TABLE, CREATE SEQUENCE, CREATE VIEW, CREATE INDEX
--���� : ALTER TABLE, ALTER VIEW, ALTER INDEX, ALTER USER

ALTER TABLE student
ADD loc varchar2(50);
-- describe                           descending
-- DESC table_name : ���̺� ���� Ȯ��,   DESC column_name : ��������
DESC student;

SELECT * FROM student;

--ORA-01441: cannot decrease column length because some value is too big
-- �����Ͱ� ����ǿ� �ִ� ���¿����� ����� ������ũ�⺸�� ������ �ȵȴ�.
ALTER TABLE student
MODIFY name varchar2(5);
--ũ�⸦ �ø��� ���� �������.
ALTER TABLE student
MODIFY name varchar2(0);

--���̺� �÷����� �����Ѵ�.
ALTER TABLE student
RENAME COLUMN avg TO jumsu;
SELECT * FROM student;

--���̺���� �����Ѵ�
ALTER TABLE student
RENAME TO members;

--ORA-04043: student ��ü�� �������� �ʽ��ϴ�.
-- student -> members�� ���̺���� �����߱� ������ �����߻�
DESC student;

DESC members;

/*================================================
TRUNCATE : ���̺� ����� �����͸� ��� �����Ѵ�.(auto COMMIT�� ��)
DROP : ���̺� ��ü�� �����Ѵ�.
DELETE : ���̺� ����� �����͸� ��� �����Ѵ�.(auto COMMIT�� �ȵ�) - ROLLBACK ����(�����õ)
==================================================*/
commit;

SELECT * FROM members;
--���̺��� ���ܵ����� �ѹ� ���� 
DELETE FROM members;

SELECT * FROM members;

ROLLBACK;

SELECT * FROM members;

commit;
--���̺��� ���ܵ����� �ѹ� �Ұ��� (�����ͻ���)
TRUNCATE TABLE members;
SELECT * FROM members;

ROLLBACK;

SELECT * FROM members;

commit;

DROP TABLE members;
--DROP�� ���̺� �÷����� ���λ����ϱ� ������ �����߻�
--ORA-00942: table or view does not exist
SELECT * FROM members;

/*================================================================
���Ἲ ��������
   ���Ἲ�� �����ͺ��̽� ���� �ִ� �������� ��Ȯ�� ������ �ǹ��Ѵٸ�
   ���������� �ٶ������� �ʴ� �����Ͱ� ����Ǵ� ���� �����ϴ� ���� ���Ѵ�.
   ���Ἲ �������� 5���� : not null, unique, primary key, foreign key, check
    not null : null�� ������� �ʴ´�.
    unique : �ߺ��� ���� ������� �ʴ´�. �׻� �����Ѱ��̴�.
    primary key : not null + unique
    foreign key : �����Ǵ� ���̺��� �÷��� ���� �����ϸ� ���ȴ�.
    check : ���� ������ �����Ͱ��� ������ ������ �����Ͽ� ������ ������ ����Ѵ�.

   ���Ἲ�������� 2���� ���� : �÷�����, ���̺���

    �÷����� ����
    CREATE TABLE emp06(
     id varchar2(10) constraint  emp06_id_pk primary key,
     name varchar2(20) constraint emp06_name_nk not null,
     age number(3) constraint emp06_age_uk check(age between 20 and 50),
     gen char(2) constraint emp06_gen_uk check(gen in('m','w')));
   
    ���̺� ���� ����-not null�� ���̺� �������� ������ �� ����.
     CREATE TABLE emp07(
     id varchar2(10),
     name varchar2(20) constraint emp07_name_nk not null,
     age number(3),
     gen char(2),
     constraint emp07_id_pk primary key(id),
     constraint emp07_age_uk check(age between 20 and 50),
     constraint emp07_gen_uk check(gen in('m','w')));
     
    --ORA-02290: üũ ��������(HR.EMP06_AGE_UK)�� ����Ǿ����ϴ�
    INSERT INTO emp06(id, name, age, gen)
    VALUES('100','PARK',15,'m');
    
    --ORA-01400: NULL�� ("HR"."EMP06"."ID") �ȿ� ������ �� �����ϴ�
    INSERT INTO emp06(id, name, age, gen)
    VALUES(null,'PARK',15,'m');
=================================================================*/

SELECT *FROM user_tables;

CREATE TABLE emp04(
  id varchar2(20) constraint emp04_id_pk primary key,
  name varchar2(50),
  age number,
  gen char(1)
);

INSERT INTO emp04(id,name,age,gen)
VALUES(1,'ȫ�浿',30,'m');

SELECT *FROM emp04;

--ORA-00001: unique constraint (HR.EMP04_ID_PK) violated
--1�� �ߺ��̱� ������ �������ǿ� �ش�
INSERT INTO emp04(id,name,age,gen)
VALUES(1,'���',25,'m');

--ORA-01400: cannot insert NULL into ("HR"."EMP04"."ID")
--null �������ǿ� �ش�
INSERT INTO emp04(id,name,age,gen)
VALUES(null,'���',25,'m');

/*=======================================================================
�������� �߰�
  ALTER TABLE table_name
       ADD constraint constraint_name constraint_type(column_name)
=========================================================================*/
SELECT *FROM emp04;

 ALTER TABLE emp04
  ADD constraint emp4_ck check(age between 20 and 50);

--ORA-02290: check constraint (HR.EMP4_CK) violated
-- ������ age�÷��� 20-50 ���� �Է��� �� �ֵ��� ������ �ɾ����� ������ ���� �߻�
INSERT INTO emp04(id,name,age,gen)
VALUES(2,'������',55,'m');

INSERT INTO emp04(id,name,age,gen)
VALUES(2,'������',30,'m');

SELECT *FROM emp04;

 ALTER TABLE emp04
  ADD constraint emp4_gen check(gen in('m','w'));

--ORA-02290: check constraint (HR.EMP4_GEN) violated
--m,w�� �����ϱ� ������ ���� �߻�
INSERT INTO emp04(id,name,age,gen)
VALUES(3,'���߱�',35,'k');

INSERT INTO emp04(id,name,age,gen)
VALUES(3,'���߱�',35,'m');

SELECT *FROM emp04;

 ALTER TABLE emp04
  ADD constraint emp4_name_uk unique(name);

--ORA-00001: unique constraint (HR.EMP4_NAME_UK) violated
--���߱��� ������(unique)�� 1�����߸� �ϱ� ������ ���� �߻�
INSERT INTO emp04(id,name,age,gen)
VALUES(4,'���߱�',35,'m');

INSERT INTO emp04(id,name,age,gen)
VALUES(5,'����',35,'m');

SELECT *FROM emp04;

INSERT INTO emp04(id,name,age,gen)
VALUES(4,'null',35,'m');

SELECT *FROM emp04;

--??;;
ALTER TABLE emp04
MODIFY name NOT NULL;

--ORA-00001: unique constraint (HR.EMP04_ID_PK) violated
INSERT INTO emp04(id,name,age,gen)
VALUES(5,'null',35,'m');

INSERT INTO emp04(id,name,age,gen)
VALUES(6,'�迬��',35,'w');

SELECT *FROM emp04;

/*=================================================
�������� ����
 ALTER TABLE table_name
  DROP constraint constraint_name
======================================================*/

ALTER TABLE emp04
DROP constraint emp4_ck;


INSERT INTO emp04(id,name,age,gen)
VALUES (7, '�ڵ���', 10, 'w');

SELECT *FROM emp04;


/*=============================================================
�������� ����
  ALTER TABLe table_name
     MODIFY column_name CONSTRAINT constraint_name constraint_type
============================================================*/
ALTER TABLE emp04
 MODIFY age CONSTRAINT emp04_ck check(age>0);
 
 INSERT INTO emp04(id,name,age,gen)
VALUES (8, '�ڼ���', 6, 'w');

SELECT *FROM emp04;

DESC emp04;

/*=========================================================================

������ ��ųʸ�(Data Dictionary)
  �����ͺ��̽��� ��ϱ� ���� �������� ��� Ư���� ���� ��Ƶΰ� �����ϴµ� 
  �̰��� ������ ��ųʸ���� �Ѵ�.
  ������ ��ųʸ���  �޸𸮱����� ���Ͽ� ���� ��������, 
  �� ������Ʈ(���̺�,������ ��)���� ���Ǵ� �������� ����, �������� ����,
  ����ڿ� ���� ����, �����̳� ��������, �ѿ����� ����, 
  ���翡 ������������ �����Ѵ�.
  constraint_type : primary key=> P     foregin key=>R
                   check, not null=>C
                   unique=>U
===========================================================================*/

SELECT * FROM user_constraints;

SELECT * FROM user_constraints
WHERE constraint_name LIKE '%EMP04%';

/*==========================================================================*/

CREATE TABLE dept01(
 deptno number(2) CONSTRAINT dept01_deptno_pk primary key,
 dname varchar2(20));
 
INSERT INTO dept01
VALUES(10,'accounting');   

INSERT INTO dept01
VALUES(20,'sales');

INSERT INTO dept01
VALUES(30,'research'); 
 
SELECT * FROM dept01; 

/*==================================*/

CREATE TABLE loc01(
  locno number(2),
  locname varchar2(20),
   CONSTRAINT loc01_locno_pk primary key(locno));
 
   INSERT INTO loc01
   VALUES(11,'seoul');
   
   INSERT INTO loc01
   VALUES(22,'jeju');
   
   INSERT INTO loc01
   VALUES(33,'busan');  
 
 SELECT * FROM loc01;

/*==================================*/
 CREATE TABLE emp07(
 
   empno number(2) constraint emp07_deptno_pk primary key,
   --�÷����� , ��ǥ X (�������� ���� - (foreign key) primary,foreign key ������ Ÿ���� �����ؾ� �Ѵ�.
   deptno number(2) 
         constraint emp07_deptno_fk references dept01(deptno),
   --���̺��� , ��ǥ�� ���� �� �� �ִ�. - (foreign key)
   locno number(2) ,
        constraint emp07_locno_fk foreign key(locno) references loc01(locno)); 


SELECT * FROM dept01;

--���� ����

 INSERT INTO emp07(empno, deptno, locno)
 VALUES(1, 10, 11);
 
 INSERT INTO emp07(empno, deptno, locno)
 VALUES(2, 20, 22);

 INSERT INTO emp07(empno, deptno, locno)
 VALUES(3, null, null);


SELECT * FROM emp07;

-- ORA-02291: integrity constraint (HR.EMP07_DEPTNO_FK) violated - parent key not found
-- parent key not found 40�� ã�� �� ���� ������ ���� 
 INSERT INTO emp07(empno, deptno, locno)
 VALUES(4, 40, 11);
 
--ORA-02291: integrity constraint (HR.EMP07_LOCNO_FK) violated - parent key not found
--�������� 44���� ����X
 INSERT INTO emp07(empno, deptno, locno)
 VALUES(4, 30, 44);
 
 SELECT * FROM emp07;
 
 DELETE FROM dept01
 WHERE deptno=30;
 
  SELECT * FROM dept01;
  
--ORA-02292: integrity constraint (HR.EMP07_DEPTNO_FK) violated - child record found
--���� �ٸ� ���̺��� (EMP07)���� �����ϰ� �ִ�. �������� ���� ���̺�ű� ������ ���� ���� 20�� �ٸ� ���̺�Ŷ� ���� �Ұ���
--���� ���踦 ����� �����ϴ� ���� ���� �� ���ִ�.
DELETE FROM dept01
 WHERE deptno=20;
 
/*=========================================================================
�ٸ� ���̺��� ���� ���̺��� �����ؼ� ����ϰ� ��������
    ���������� �������� ���� ���̺��� �����͸� �����Ѵ�.
==========================================================================*/
 
--���� ���谡 ������.
 ALTER TABLE emp07
 DROP CONSTRAINT emp07_deptno_fk;
 
 DELETE FROM dept01
 WHERE deptno=20;
 
SELECT * FROM dept01;
SELECT * FROM emp07;

/*=========================================================
�θ�Ű�� ������ �Ǹ� �����Ǵ� Ű�� ������ �ǵ��� cascade�� �����Ѵ�.
==========================================================*/
--����
INSERT INTO dept01
VALUES(20,'sales');

SELECT * FROM dept01;
SELECT * FROM emp07;

 -- CASCADE ����
ALTER TABLE emp07
 ADD constraint emp07_deptno_rk foreign key(deptno) references dept01(deptno) ON DELETE CASCADE;

  SELECT * FROM dept01;
SELECT * FROM emp07;
  
  
DELETE FROM dept01
WHERE deptno=10;

SELECT * FROM dept01;
SELECT * FROM emp07;

--������ ����� ������ ����
CREATE OR REPLACE TRIGGER dept_tri
--dept01�� ������Ʈ �ǰ� ���� begin�� �����϶�.
AFTER UPDATE ON dept01 FOR EACH ROW
 BEGIN
  UPDATE emp07
  SET deptno=50
  WHERE deptno=20;
 END;
/ 
-- /(������)�� ����

UPDATE dept01
SET deptno=50
WHERE deptno=20;

SELECT * FROM dept01;
SELECT * FROM emp07;