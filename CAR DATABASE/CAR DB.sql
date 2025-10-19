create database carinsurance1;

use carinsurance1;

create table person (
driver_id varchar(20),
name varchar(10),
address varchar(14),
primary key(driver_id));

create table car (
reg_num varchar(10),
model varchar(11),
year int,
primary key(reg_num));

create table accident (
report_num int,
accident_date date,
location varchar(14),
primary key (report_num)); 

create table owns (
driver_id varchar(10),
reg_num varchar(10),
primary key(driver_id,reg_num),
foreign key (driver_id) references person(driver_id),
foreign key(reg_num) references car(reg_num));

create table participated (
driver_id varchar(10),
reg_num varchar(10),
report_num int,
damage_amount int,
primary key (driver_id,reg_num,report_num),
foreign key(driver_id) references person(driver_id),
foreign key(reg_num) references car(reg_num),
foreign key(report_num) references accident(report_num));

show tables;

insert into person values("A01","RICHARD","SRINIVAS NAGAR");
insert into person values("A02","PRADEEP ","RAJAJINAGAR");
insert into person values("A03","SMITH","ASHOKNAGAR");
insert into person values("A04","VENU","NR COLONY ");
insert into person values("A05","JHON","HANUMANTHNAGAR");

select*from person;

insert into car values("KA052250","INDICA",1990);
insert into car values("KA031181","LANCER",1957);
insert into car values("KA095477","TOYATO",1998);
insert into car values("KA053408","HONDO",2008);
insert into car values("KA041702","AUDI",2005);

select*from car;

insert into owns values("A01","KA052250");
insert into owns values("A02","KA053408");
insert into owns values("A03","KA031181");
insert into owns values("A04","KA095477");
insert into owns values("A05","KA041702");

select*from owns;

insert into accident values(11,"01-01-03","MYSORE ROAD");
insert into accident values(12,"02-02-04","SOUTHENDCIRCLE");
insert into accident values(13,"21-01-03","BULLTEMPLEROAD");
insert into accident values(14,"17-02-08","MYSORE ROAD");
insert into accident values(15,"04-04-05","KANAKPURAROAD");

select*from accident;

insert into participated values("A01","KA052250",11,10000);
insert into participated values("A02","KA053408",12,50000);
insert into participated values("A03","KA095477",13,25000);
insert into participated values("A04","KA031181",14,3000);
insert into participated values("A05","KA041702",15,5000);

select*from participated;

select accident_date,location from accident;

select driver_id from participated where damage_amount>=25000; 

select count(Distinct driver_id) 
from participated a,accident b
where a.report_num=b.report_num
and b.accident_date like '%8';

select avg(damage_amount) from participated;

select * from participated 
order by damage_amount desc;


select max(damage_amount) from participated;

select * from car order by year asc;

update participated set damage_amount=25000
where reg_num="KA053408" and
report_num=12;

select*from participated;

insert into accident values(16,'2008-03-08',"domlur");

select*from accident;

select count(p.reg_num) from participated p,car c where p.reg_num=c.reg_num and c.model="LANCER";

select (a.name) from person a,participated b 
where a.driver_id=b.driver_id and 
b.damage_amount >
(select avg(damage_amount)from participated);