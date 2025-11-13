create database supplier;
use supplier;

create table supplier (
sid int primary key,
sname varchar(50),
city varchar(50));

create table parts (
pid int primary key,
pname varchar(50),
color varchar(50));

create table catalog (
sid int,
pid int,
cost float,
primary key(sid,pid),
foreign key(sid) references supplier(sid),
foreign key(pid) references parts (pid));

insert into supplier values(10001,'Acme Widget','Banglore'),
(10002,'Johns','Kolkota'),(10003,'Vimal','Mumbai'),(10004,'Reliance','Delhi');

select*from supplier;

insert into parts values(20001,'Book','Red'),(20002,'Pen','Red'),(20003,'Pencil','Green'),(20004,'Mobile','Green'),
(20005,'Charger','Black');

select*from parts;

insert into catalog values
(10001,20001,10),
(10001,20002,10),
(10001,20003,30),
(10001,20004,10),
(10001,20005,10),
(10002,20001,10),
(10002,20002,20),
(10003,20003,30),
(10004,20003,40);

select*from catalog;

select  distinct p.pname from parts p
join catalog c
on p.pid=c.pid;
 
SELECT s.sname
FROM supplier s
JOIN Catalog c ON s.sid = c.sid
GROUP BY s.sid, s.sname
HAVING COUNT(DISTINCT c.pid) = (SELECT COUNT(*) FROM Parts);

SELECT  distinct s.sname
FROM Supplier s
JOIN Catalog c ON s.sid = c.sid
JOIN Parts p ON c.pid = p.pid
WHERE p.color = 'red';

SELECT p.pname
FROM Parts p
JOIN Catalog c ON p.pid = c.pid
JOIN Supplier s ON c.sid = s.sid
GROUP BY p.pid, p.pname
HAVING COUNT(DISTINCT s.sid) = 1
   AND MAX(s.sname) = 'Acme Widget';
   
select  distinct s.sid from supplier  
where s.si   

Select  DISTINCT c.sid
FROM Catalog c
WHERE cost > (SELECT AVG(cost) FROM Catalog WHERE pid = c.pid);

select s.sname,p.pid from supplier s 
join catalog c on s.sid=c.sid
where c.cost=(select max(cost) from catalog 
where pid=c.pid);

SELECT c.pid,s.sname
FROM supplier s
JOIN catalog c ON s.sid = c.sid
WHERE c.cost = (
    SELECT MAX(cost)
    FROM catalog
    WHERE pid = c.pid
);















