create database bank;

use bank;

create table branch (
branch_name varchar(25),
branch_city varchar(25),
assests int,
primary key(branch_name)
);

create table bankaccount (
acc_no int,
branch_name varchar(25),
balance int,
primary key(acc_no),
foreign key (branch_name) references branch (branch_name)
);

create table depositer (
customer_name varchar(25),
acc_no int,
primary key(customer_name,acc_no),
foreign key(acc_no) references bankaccount (acc_no),
foreign key (customer_name) references bankcustomer(customer_name)
);



create table bankcustomer (
customer_name varchar(25),
customer_street varchar(25),
city varchar(25),
primary key(customer_name)
);

create table loan (
loan_number int,
branch_name varchar(25),
amount int,
primary key(loan_number),
foreign key (branch_name) references branch (branch_name)
);

insert into branch values("sbi_chamrajpet","banglore",50000),
("sbi_recidencyroad","banglore",10000),
("sbi_shivajiroad","bombay",20000),("sbi_parlimentroad","delhi",10000),
("sbi_jantarmantar","delhi",20000);

insert into bankaccount values(1,"sbi_chamrajpet",2000),
(2,"sbi_recidencyroad",5000),
(3,"sbi_shivajiroad",6000),
(4,"sbi_parlimentroad",9000),
(5,"sbi_jantarmantar",8000),
(6,"sbi_shivajiroad",4000),
(7,"sbi_recidencyroad",4000),
(8,"sbi_parlimentroad",3000),
(9,"sbi_recidencyroad",5000),
(10,"sbi_jantarmantar",2000);

insert into bankcustomer values("avinash","bull_temple_road","banglore"),
("dinesh","banergatta_road","banglore"),
("mohan","nationalcollage_road","banglore"),
("nikhil","akbar_road","delhi"),
("ravi","pritiviraj_road","delhi");

insert into depositer values("avinash",1),("dinesh",2),("nikhil",4),("ravi",5),("avinash",7),("nikhil",8),("dinesh",9),("nikhil",10);

insert into loan values(1,"sbi_chamrajpet",1000),
(2,"sbi_recidencyroad",2000),
(3,"sbi_shivajiroad",3000),
(4,"sbi_parlimentroad",4000),
(5,"sbi_jantarmantar",5000);

show tables;

select*from branch;
select*from bankaccount;
select * from depositer; 
select*from bankcustomer;
select*from loan;

select d.customer_name,b.branch_name,
count(*) as num_of_depo
from depositer d
join bankaccount b on d.acc_no=b.acc_no
group by customer_name,branch_name
having count(*)>=2;

select branch_name ,assests/100000 as "assists_in_lakhs" from branch;

SELECT d.customer_name, b.branch_name, COUNT(*) AS num_accounts
FROM Depositer d
JOIN BankAccount b ON d.acc_no = b.acc_no
GROUP BY d.customer_name, b.branch_name
HAVING COUNT(*) >= 2;

CREATE VIEW BranchLoanSummary AS
SELECT branch_name, SUM(amount) AS total_loans
FROM Loan
GROUP BY branch_name;

SELECT * FROM BranchLoanSummary;

SELECT d.customer_name, b.branch_name, COUNT(*) AS num_accounts
FROM Depositer d
JOIN BankAccount b ON d.acc_no = b.acc_no
GROUP BY d.customer_name, b.branch_name
HAVING COUNT(*) >= 2;

SELECT DISTINCT d.customer_name
FROM Depositer d
JOIN BankAccount b ON d.acc_no = b.acc_no
JOIN Loan l ON b.branch_name = l.branch_name
WHERE b.branch_name = 'Bangalore';

SELECT branch_name
FROM Branch
WHERE assests > (
    SELECT MAX(assets)
    FROM Branch
    WHERE branch_city = 'Bangalore'
);

DELETE FROM BankAccount
WHERE branch_name IN (
    SELECT branch_name
    FROM Branch
    WHERE branch_city = 'Delhi'
);

UPDATE BankAccount
SET balance = balance * 1.05;

SELECT accno, branch_name, balance AS new_balance
FROM BankAccount;



