CREATE DATABASE Bank;
USE Bank;

CREATE TABLE Branch(
branch_name VARCHAR(50) PRIMARY KEY,
branch_city VARCHAR(50),
assets int
);

CREATE TABLE BankAccount(
acc_no INT PRIMARY KEY,
branch_name VARCHAR(50),
balance DECIMAL(15,2),
FOREIGN KEY (branch_name) REFERENCES Branch(branch_name)
);

CREATE TABLE BankCustomer(
customer_name VARCHAR(50) PRIMARY KEY,
customer_street VARCHAR(100),
customer_city VARCHAR(50)
);

CREATE TABLE Depositer (
    customer_name VARCHAR(50),
    acc_no INT,
    PRIMARY KEY (customer_name, acc_no),
    FOREIGN KEY (customer_name) REFERENCES BankCustomer(customer_name),
    FOREIGN KEY (acc_no) REFERENCES BankAccount(acc_no)
);
CREATE TABLE Loan (
    loan_number INT PRIMARY KEY,
    branch_name VARCHAR(50),
    amount DECIMAL(15,2),
    FOREIGN KEY (branch_name) REFERENCES Branch(branch_name)
);

INSERT INTO Branch VALUES
('SBI_ResidencyRoad', 'Bangalore', 50000),
('SBI_Jayanagar', 'Bangalore', 30000),
('HDFC_Kormangala', 'Bangalore', 45000),
('ICICI_MGroad', 'Bangalore', 40000),
('SBI_Whitefield', 'Bangalore', 350000);

select*from branch;


INSERT INTO BankAccount VALUES
(101, 'SBI_ResidencyRoad', 50000),
(102, 'SBI_ResidencyRoad', 75000),
(103, 'SBI_Jayanagar', 60000),
(104, 'HDFC_Kormangala', 80000),
(105, 'SBI_ResidencyRoad', 55000);

select*from BankAccount;

INSERT INTO BankCustomer VALUES
('Ramesh', 'MG Road', 'Bangalore'),
('Suresh', 'Jayanagar', 'Bangalore'),
('Mahesh', 'Indiranagar', 'Bangalore'),
('Anita', 'Koramangala', 'Bangalore'),
('Priya', 'Whitefield', 'Bangalore');

select*from BankCustomer;


INSERT INTO Depositer VALUES
('Ramesh', 101),
('Ramesh', 102),
('Suresh', 103),
('Mahesh', 104),
('Ramesh', 105);

select*from Depositer;


INSERT INTO Loan VALUES
(201, 'SBI_ResidencyRoad', 200000),
(202, 'SBI_ResidencyRoad', 300000),
(203, 'SBI_Jayanagar', 150000),
(204, 'HDFC_Kormangala', 250000),
(205, 'ICICI_MGroad', 180000);

select*from loan;


SELECT branch_name, (assets/100000) AS "assets in lakhs"
FROM Branch;

SELECT d.customer_name, b.branch_name, COUNT(*) AS num_accounts
FROM Depositer d
JOIN BankAccount b ON d.acc_no = b.acc_no
GROUP BY d.customer_name, b.branch_name
HAVING COUNT(*) >= 2;

CREATE VIEW BranchLoanSummary AS
SELECT branch_name, SUM(amount) AS total_loans
FROM Loan
GROUP BY branch_name;

select *from BranchLoanSummary;



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
WHERE assets > (
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

select distinct s.customername from depositer s
where not exists ((select branch_name from branch where branch_city="Delhi") except (select
r.branch_name from depositer t, bankaccount r
where t.accno=r.accno and
s.customername=t.customername));