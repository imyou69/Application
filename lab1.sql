Create table Publisher(Name varchar2(10) Primary Key, Address Varchar(20), Phone int);
Insert into Publisher Values('KVS','Bangalore',9535616745);
Insert into Publisher Values('Westland','Pune',8768916745);
Insert into Publisher Values('Rupa','Bangalore',6478989715);
Insert into Publisher Values('Ganga','Mumbai',9876985645);
Insert into Publisher Values('Hachette','Mattur',7013458745);

Select * From Publisher;

Create table Book(B_id int Primary Key, title Varchar(20), Pub_name Varchar(20) References Publisher(Name) on delete cascade,pub_year int);
Insert into Book Values(1,'McGraw-Hill','Ganga',2001);
Insert into Book Values(2,'My Artemis','KVS',2004);
Insert into Book Values(3,'Chemistry Vol 1','Westland',2006);
Insert into Book Values(4,'Uprising','Rupa',2018);
Insert into Book Values(5,'Chemistry Vol 2','Westland',2021);
Select * from Book;
ALTER TABLE Book
ADD pub_year int;
UPDATE Book
SET pub_year = 2021 
WHERE B_id= 5;

Create table Book_author(B_id int, Author_name Varchar(20), Primary Key(B_id, Author_name), Foreign Key(B_id) References Book(B_id) on delete cascade);

Insert into Book_author Values(1,'Ashish C');
Insert into Book_author Values(2,'Aneesha');
Insert into Book_author Values(3,'Aditya Kul C');
Insert into Book_author Values(4,'Saquib M');
Insert into Book_author Values(5,'Arjun S');

Select * from Book_author;


Create table Library_pgm(P_id int Primary Key, P_name Varchar(20), Address Varchar(30));

Insert into Library_pgm Values(101,'Book Axis','Bangalore');
Insert into Library_pgm Values(102,'Book Square','Pune');
Insert into Library_pgm Values(103,'Claus Books','Mumbai');
Insert into Library_pgm Values(104,'Comic Con','Pune');
Insert into Library_pgm Values(105,'Fandom','Bangalore');

Select * from Library_pgm;

Create table Book_copies(B_id int, P_id int, no_of_copies int, Primary Key(B_id, P_id), Foreign Key(B_id) References Book(B_id) on delete cascade, Foreign Key(P_id) References Library_pgm(P_id) on delete cascade);

Insert into Book_copies Values(1,102,40);
Insert into Book_copies Values(2,101,18);
Insert into Book_copies Values(3,104,53);
Insert into Book_copies Values(4,103,4);
Insert into Book_copies Values(5,105,20);

Select * from Book_copies;

Create table Book_lending(B_id int, P_id int, card_no int, date_out date, due_date date, Primary Key(B_id, P_id, card_no), Foreign Key(B_id) References Book(B_id) on delete cascade, Foreign key(P_id) References Library_pgm(P_id) on delete cascade);

Insert into Book_lending Values(1,101,5001,'21-Sep-2021','19-Oct-2021');
Insert into Book_lending Values(1,102,5002,'7-Jul-2017','18-May-2017');
Insert into Book_lending Values(2,102,5003,'2-Feb-2017','22-Mar-2020');
Insert into Book_lending Values(3,103,5004,'14-Sep-2016','8-Oct-2021');
Insert into Book_lending Values(5,104,5005,'18-Jun-2020','14-Aug-2021');
Insert into Book_lending Values(2,102,5002,'7-Jan-2017','18-May-2017');
Insert into Book_lending Values(3,102,5002,'2-Feb-2017','22-Mar-2020');
Insert into Book_lending Values(4,102,5002,'14-Mar-2017','8-May-2019');


Select * from Book_lending;

select LB.P_name,B.B_id,title,Pub_name,Author_name,no_of_copies
from Book B, Book_author BA, Book_copies BC, Library_pgm LB
where B.B_id=BA.B_id and BA.B_id=BC.B_id and BC.P_id=LB.P_id
Group by LB.P_name,B.B_id,title,Pub_name,Author_name,no_of_copies;

select card_no from Book_lending
where date_out>'1-Jan-2017' and due_date<'1-Jun-2021'
group by card_no having count(*)<3;

delete from book where B_id=1;

create view v_publication as
select pub_year from Book
select * from v_publication;

create view Book_available as
select B.B_id,B.title,C.no_of_copies
from Library_pgm L,Book B,Book_copies C where B.B_id=C.B_id and L.P_id=C.P_id ;

select * from Book_available;


LAB2 

create table student (USN varchar (20) primary key, sname varchar (20), address varchar (20), phone int, gender varchar (20)) ;
create table semsec(SSID varchar (20) primary key, sem int, sec char);
CREATE TABLE class (
    USN VARCHAR(20),
    SSID VARCHAR(20),
    PRIMARY KEY (USN, SSID),
    FOREIGN KEY (USN) REFERENCES student (USN) ON DELETE CASCADE,
    FOREIGN KEY (SSID) REFERENCES semsec (SSID) ON DELETE CASCADE
);
create table course2(subcode varchar(20) primary key, title varchar(20),sem int, credit int);
create table iamarks(USN varchar(20), subcode  varchar(20), SSID  varchar(20) , primary key(USN,subcode,SSID),
FOREIGN KEY (USN) REFERENCES student (USN) ON DELETE CASCADE,
    FOREIGN KEY (SSID) REFERENCES semsec (SSID) ON DELETE CASCADE,
 FOREIGN KEY (subcode) REFERENCES course (subcode) ON DELETE CASCADE,
test1 int,test2 int, test3 int, finalIA float);




insert into student values('1DS22IS049','ARJUN','BANGALORE',95379823498,'MALE');
insert into student values('1DS22IS022','ADITYA','BANGALORE',7364876347,'MALE');
insert into student values('1DS22IS017','ANEESH','MATTUR',8528798579834,'MALE');
insert into student values('1DS22IS058','VARSHA','PUNE',3479283748934,'FEMALE');
insert into student values('1DS22IS007','RUPA','MANGALORE',8348748587,'FEMALE');
SELECT * FROM student;


insert into semsec values('4A01',4,'A');
insert into semsec values('4C02',4,'C');
insert into semsec values('8A01',8,'A');
insert into semsec values('8C03',8,'C');
insert into semsec values('5A01',5,'A');
SELECT * FROM semsec;


insert into class values('1DS22IS049','8A01');
insert into class values('1DS22IS022''8A01');
insert into class values('1DS22IS017','4C02');
insert into class values('1DS22IS058','4C02');
insert into class values('1DS22IS007','5A01');
SELECT * FROM class;


insert into course2 values('1','DBMS',5,4);
insert into course2 values('3','CHEMISTRY',8,4);
insert into course2 values('4','CNCS',4,2);
insert into course2 values('5','PP',5,3);
SELECT * FROM course;
drop table course;


insert into iamarks values('1DS22IS049','1','8A01',19,18,20,19);
insert into iamarks values('1DS22IS022','3','8A01',18,12,13,15.5);
insert into iamarks values('1DS22IS017','4','4C02',2,4,3,3.5);
insert into iamarks values('1DS22IS058',4,'4C02',14,16,18,17);
insert into iamarks values('1DS22IS007',5,'5A01',18,16,17,17);
select * from iamarks;

select s1.* from student s1,semsec s2,class c where s1.USN=c.USN and c.SSID=s2.SSID and s2.sem=4 and s2.sec='C';


select s.gender , ss.sem, ss.sec, count(gender) from student s,semsec ss, class c where s.USN=c.USN and c.SSID=ss.SSID group by s.gender,ss.sem,ss.sec;


create view IAmarks_1 as select subcode,test1 from iamarks where USN='1DS22IS049';
select * from IAmarks_1;


UPDATE iamarks 
SET finalIA = (
    (GREATEST(test1, test2, test3) + ((test1 + test2 + test3) - GREATEST(test1, test2, test3) - LEAST(test1, test2, test3))) / 2
);
select * from iamarks;

select ss.sec,s.*,(case when IA.finalIA between 17and 20 then 'OUTSTANDING' when IA.finalIA between 12 and 16 then 'AVERAGE' else 'WEAK' end) As cat from student s,semsec ss, iamarks IA,course sub where s.USN=IA.USN and ss.SSID=IA.SSID and sub.subcode=IA.subcode and sub.sem=8;


LAB 3

create table dept (dno int primary key, dname varchar (20),mgrSSN int,mgrstartdate date);
CREATE TABLE employee (
    SSN int primary key,
    name varchar (20),
    address varchar (20),
    sex char,
    salary float,
    superSSN varchar (20),
    dno int,
    FOREIGN KEY (dno) REFERENCES dept(dno) ON DELETE CASCADE
);
create table dlocation( dno int primary key, dloc varchar (20), foreign key (dno) references dept(dno) on delete cascade);
create table project (pno int primary key,pname varchar (20),ploc varchar (20),dno int, foreign key (dno) references dept(dno) on delete cascade);
CREATE TABLE workson (SSN int,pno int, hours int, FOREIGN KEY (pno) REFERENCES project(pno) ON DELETE CASCADE,FOREIGN KEY (SSN) REFERENCES employee (SSN) ON DELETE CASCADE);


-- Inserting values for departments
INSERT INTO dept VALUES (1, 'Engineering', 123456789, '01-JAN-2023');
INSERT INTO dept VALUES (2, 'Marketing', 234567890, '15-FEB-2023');
INSERT INTO dept VALUES (3, 'Finance', 345678901,'20-MAR-2023');
INSERT INTO dept VALUES (4, 'Human Resources', 456789012, '10-APR-2023');
INSERT INTO dept VALUES (5, 'Research', 567890123,'05-MAY-2023');
INSERT INTO dept VALUES (6, 'Finance', 345676801,'20-MAR-2023');
INSERT INTO dept VALUES (7, 'Finance', 345678901,'20-MAR-2023');
INSERT INTO dept VALUES (8, 'Finance', 345679901,'20-MAR-2023');
INSERT INTO dept VALUES (9, 'Finance', 345676901,'20-MAR-2023');
INSERT INTO dept VALUES (10, 'Finance', 345677901,'20-MAR-2023');
truncate table dept;

INSERT INTO employee VALUES (101, 'John Doe', '123 Main St', 'M', 600000.00, 60, 1);
INSERT INTO employee VALUES (201,'Michael Johnson', '124 Main St', 'M', 700000.00, 61, 2);
INSERT INTO employee VALUES (301,'Jessica White', '125 Main St', 'F', 800000.00, 62, 3);
INSERT INTO employee VALUES (401, 'William Clark', '126 Main St', 'M', 100000.00, 63, 4);
INSERT INTO employee VALUES (501, 'Olivia Hall', '127 Main St', 'F', 300000.00, 65, 5);
INSERT INTO employee VALUES (601,'Amber', '125 Main St', 'F', 700000.00, 66, 6);
INSERT INTO employee VALUES (701,'Skyler', '125 Main St', 'F', 900000.00, 67, 7);
INSERT INTO employee VALUES (801,'Walter White', '125 Main St', 'F', 800000.00, 68, 8);
INSERT INTO employee VALUES (901,'Butcher', '125 Main St', 'F', 610000.00, 69, 9);
INSERT INTO employee VALUES (1001,'Homelander', '125 Main St', 'F', 710000.00, 70, 10);
select * from employee

-- Inserting values for department locations
INSERT INTO dlocation VALUES (1, 'New York');
INSERT INTO dlocation VALUES (2, 'Los Angeles');
INSERT INTO dlocation VALUES (3, 'Chicago');
INSERT INTO dlocation VALUES (4, 'Houston');
INSERT INTO dlocation VALUES (5, 'San Francisco');

-- Inserting values for projects
INSERT INTO project VALUES (1, 'Project A', 'New York', 1);
INSERT INTO project VALUES (2, 'Project B', 'Los Angeles', 2);
INSERT INTO project VALUES (3, 'Project C', 'Chicago', 3);
INSERT INTO project VALUES (4, 'Project D', 'Houston', 4);
INSERT INTO project VALUES (5, 'Project E', 'San Francisco', 5);

INSERT INTO workson values(101,1,10);
INSERT INTO workson values(201,2,12);
INSERT INTO workson values(301,3,15);
INSERT INTO workson values(401,4,18);


SELECT DISTINCT P.pno
FROM project P, dept D, employee E
WHERE P.dno = D.dno
  AND E.name = 'John Doe'
  AND P.dno = E.dno

UNION

SELECT DISTINCT P.pno
FROM project P, workson W, employee E
WHERE P.pno = W.pno
  AND W.SSN = E.SSN
  AND E.name = 'John Doe';


select E.name,1.1*E.salary as hike_salary
from project P,workson W,employee E
where P.pno=W.pno and W.SSN=E.SSN and P.pname='Project C';


SELECT 
    SUM(E.salary) AS sum_sal,
    MAX(E.salary) AS max_sal,
    MIN(E.salary) AS min_sal,
    AVG(E.salary) AS avg_sal
FROM 
    employee E, dept D
WHERE 
    E.dno = D.dno
    AND D.dname = 'Finance';


SELECT E.name
FROM employee E
WHERE NOT EXISTS (
    (SELECT P.pno FROM project P WHERE P.dno = 5)
    MINUS
    (SELECT W.pno FROM workson W WHERE E.SSN = W.SSN)
);

SELECT dno, COUNT(*) AS no_of_emp 
FROM employee 
WHERE salary > 60000
  AND dno IN (SELECT dno 
              FROM employee 
              GROUP BY dno 
              HAVING COUNT(*) > 0)
GROUP BY dno;