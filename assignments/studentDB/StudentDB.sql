drop table StudentDB
create table StudentDB(FName varchar(20), LName varchar(20), semester varchar(20),
   year int, CourseID varchar(20), CourseDesc varchar(20), units int, grade char(2))

LOAD DATA 
LOCAL INFILE 'D:/Documents/GitHub/CSci226.Fall13/assignments/StudentDB/StudentDB.druby.csv' 
INTO TABLE StudentDB
FIELDS TERMINATED BY ',';

select * from StudentDB
delete from StudentDB

select * from StudentDB
select * from StudentDB where semester = 'Fall'
select * from StudentDB where semester = 'Fall' and year=2013
select '2013', count(*) from StudentDB where semester = 'Fall' and year=2013

LOAD DATA 
LOCAL INFILE 'D:/Documents/GitHub/CSci226.Fall13/assignments/StudentDB/StudentDB.csci226.csv' 
INTO TABLE StudentDB
FIELDS TERMINATED BY ',';
