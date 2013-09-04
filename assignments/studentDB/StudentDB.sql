create database StudentDB
use StudentDB
drop table StudentDB
create table StudentDB(FName varchar(20), LName varchar(20), semester varchar(20),
   year int, CourseID varchar(20), CourseDesc varchar(20), units int, grade char(2))

drop table Person
create table Person(pid int primary key auto_increment, FName varchar(20), LName varchar(20)) auto_increment=1000;

create table Transcript(sid int, semester varchar(20),
   year int, CourseID varchar(20), CourseDesc varchar(20), units int, grade char(2))


/* Desktop Machine */
LOAD DATA 
LOCAL INFILE 'D:/Documents/GitHub/CSci226.Fall13/assignments/StudentDB/StudentDB.druby.csv' 
INTO TABLE StudentDB
FIELDS TERMINATED BY ',';

LOAD DATA 
LOCAL INFILE 'D:/Documents/GitHub/CSci226.Fall13/assignments/StudentDB/StudentDB.csci226.csv' 
INTO TABLE StudentDB
FIELDS TERMINATED BY ',';

/* Laptop */
LOAD DATA 
LOCAL INFILE 'C:/Users/Administrator/Documents/GitHub/CSci226.Fall13/assignments/StudentDB/StudentDB.druby.csv' 
INTO TABLE StudentDB
FIELDS TERMINATED BY ',';

LOAD DATA 
LOCAL INFILE 'C:/Users/Administrator/Documents/GitHub/CSci226.Fall13/assignments/StudentDB/StudentDB.druby.csv' 
INTO TABLE StudentDB
FIELDS TERMINATED BY ','
(FName, LName, semester, year, CourseID, CourseDesc, units, grade);
 
LOAD DATA 
LOCAL INFILE 'C:/Users/Administrator/Documents/GitHub/CSci226.Fall13/assignments/StudentDB/StudentDB.csci226.csv' 
INTO TABLE StudentDB
FIELDS TERMINATED BY ',';

LOAD DATA 
LOCAL INFILE 'C:/Users/Administrator/Documents/GitHub/CSci226.Fall13/assignments/StudentDB/StudentDB.csci226.csv' 
INTO TABLE StudentDB
FIELDS TERMINATED BY ','
(FName, LName, semester, year, CourseID, CourseDesc, units, grade);

select * from StudentDB
delete from StudentDB

select * from StudentDB
select * from StudentDB where semester = 'Fall'
select * from StudentDB where semester = 'Fall' and year=2013
select 'Fall', '2013', count(*) from StudentDB where semester = 'Fall' and year=2013

select grade from StudentDB where grade like 'B%'
select grade from StudentDB where grade = 'B'
select * from StudentDB where grade = 'B'
select count(*) from StudentDB where grade ='B'
 
update StudentDB set grade = 'B' where grade like 'B%'
select * from StudentDB where grade like 'C%' and grade != 'CR'

update StudentDB set FName = 'Antony' where FName = 'Anthony'

insert into Person (FName, LName) 
select FName, LName from StudentDB group by FName, LName;
select * from Person
  
insert into Transcript select  
   pid, semester, year, CourseID, CourseDesc, units, grade
   from StudentDB join Person 
   on StudentDB.FName = Person.FName and 
   StudentDB.LName = Person.LName

select * from Transcript join Person on Transcript.sid = Person.pid

drop table JobHistory
create table JobHistory (pid int, jobtitle varchar(40), company varchar(40), startdate date, enddate date,
   description varchar(512));
 
delete from JobHistory;
insert into JobHistory values (1001, "Software Engineer", "Edwards Air Force Base", "1984-06-15", "1986-08-06",
   "* Responsible for the management of 6,600 line Fortran77 "
    "system UFTAS (Unified Flight Test Analysis System).\n "
    "* Created 1,100 line Fortran77 system mini UFTAS , used by Fire & Ice test of Rockwell :"
    "B1 Bomber @ Eglin Air Force Base, and part of Schweizer SA-2-37A in Horseheads, New York.\n" );

insert into JobHistory values (1001, "Software Engineer", "Orbit Technology Corporation", "1994-02-02", "1996-02-02",
   "* Responsible for design and development of new 1,230 line C++ Windows User Interface for Cad/Cam System.");

select * from JobHistory