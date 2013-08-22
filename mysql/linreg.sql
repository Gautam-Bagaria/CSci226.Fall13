select count(*) from songs ;

select sum(High) from songs limit 50000;
select sum(CH) from songs limit 50000;
select sum(CH2) from
 (select power(CH,2) as CH2 from songs limit 50000) x

select sum(High2) from
 (select power(High,2) as High2 from songs limit 50000) x

select sum(CH*High) as XY from songs limit 50000
 
select count(CH) from songs
drop database cs126
create database cs126a
select * from r1

use cs126a
create table iris_2d (x float, y float, class varchar(30));
 
LOAD DATA 
LOCAL INFILE 'D:/Documents/GitHub/CSci226.Fall13/assignments/iris/iris.2D.csv' 
INTO TABLE iris_2d
FIELDS TERMINATED BY ',';

LOAD DATA 
LOCAL INFILE 'C:/Users/Administrator/Documents/GitHub/CSci226.Fall13/assignments/iris/iris.2D.csv'
INTO TABLE iris_2d
FIELDS TERMINATED BY ',';


select * from iris_2d;

select x,y from iris_2D where class = "Iris-setosa"
select * from iris_2D where class like "Iris-setosa%"
delete from iris_2d;
drop table iris_2d;