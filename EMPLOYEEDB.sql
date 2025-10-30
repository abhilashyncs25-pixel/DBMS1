CREATE DATABASE employee_db;
USE employee_db;

CREATE TABLE dept (
  deptno INT PRIMARY KEY,
  dname VARCHAR(25),
  dloc  VARCHAR(25)
);

CREATE TABLE employee (
  empno   INT PRIMARY KEY,
  ename   VARCHAR(25),
  mgrno   INT,
  hiredate DATE,
  salary  INT,
  deptno  INT,
  FOREIGN KEY (deptno) REFERENCES dept(deptno)
); 

CREATE TABLE project (
  pno INT PRIMARY KEY,
  ploc VARCHAR(25),
  pname VARCHAR(25)
);

CREATE TABLE assignedto (
  empno INT,
  pno   INT,
  jobrole VARCHAR(25),
  PRIMARY KEY (empno, pno),
  FOREIGN KEY (empno) REFERENCES employee(empno),
  FOREIGN KEY (pno)   REFERENCES project(pno)
);

CREATE TABLE incentives (
  empno INT,
  incentive_date DATE,
  incentive_amount INT,
  PRIMARY KEY (empno, incentive_date),
  FOREIGN KEY (empno) REFERENCES employee(empno)
);

INSERT INTO dept VALUES (101, 'IT', 'banglore');
INSERT INTO dept VALUES (102, 'HR', 'delhi');
INSERT INTO dept VALUES (103, 'FINANCE', '');
INSERT INTO dept VALUES (104, 'MARKETING','mysuru');
INSERT INTO dept VALUES (105, 'SUPPORT',  'banglore');
INSERT INTO dept VALUES (106, 'TESTING',  'udupi');


INSERT INTO employee VALUES (10, 'abhilash', 20, '2020-04-11', 45000, 101);
INSERT INTO employee VALUES (20, 'abhay',    10, '2022-09-01', 50000, 102);
INSERT INTO employee VALUES (30, 'aman',     40, '2021-11-05', 55000, 101);
INSERT INTO employee VALUES (40, 'abhishek', 30, '2025-11-05', 60000, 105);
INSERT INTO employee VALUES (50, 'jayanth',  40, '2024-04-04', 75000, 106);


INSERT INTO project VALUES (201, 'Bangalore', 'AI System');
INSERT INTO project VALUES (202, 'Hyderabad', 'Banking App');
INSERT INTO project VALUES (203, 'Mysuru',    'E-Commerce');
INSERT INTO project VALUES (204, 'Delhi',     'Hospital Management');
INSERT INTO project VALUES (205, 'Bangalore', 'ChatBot');

INSERT INTO assignedto VALUES (10, 201, 'Developer');
INSERT INTO assignedto VALUES (20, 202, 'Analyst');
INSERT INTO assignedto VALUES (30, 203, 'Tester');
INSERT INTO assignedto VALUES (40, 204, 'Project Manager');
INSERT INTO assignedto VALUES (30, 205, 'Team Lead');


INSERT INTO incentives VALUES (10, '2024-12-25', 5000);
INSERT INTO incentives VALUES (20, '2025-01-15', 4000);
INSERT INTO incentives VALUES (30, '2025-02-10', 3500);
INSERT INTO incentives VALUES (40, '2025-03-05', 6000);
INSERT INTO incentives VALUES (50, '2025-04-01', 7000);

SELECT * FROM dept;
SELECT * FROM employee;
SELECT * FROM project;
SELECT * FROM assignedto;
SELECT * FROM incentives;

SELECT DISTINCT a.empno
FROM assignedto a
JOIN project p ON a.pno = p.pno
WHERE p.ploc IN ('Bangalore', 'Hyderabad', 'Mysuru');

SELECT empno
FROM employee
WHERE empno NOT IN (SELECT empno FROM incentives);


