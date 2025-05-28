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
