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