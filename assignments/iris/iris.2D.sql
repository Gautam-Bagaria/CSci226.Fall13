create database iris2d
use iris2d
drop table iris_2d
create table iris_2d (petallength float, petalwidth float, class varchar(30));
 
/* PC */
LOAD DATA 
LOCAL INFILE 'D:/Documents/GitHub/CSci226.Fall13/assignments/iris/iris.2D.csv' 
INTO TABLE iris_2d
FIELDS TERMINATED BY ',';

/* Laptop */
LOAD DATA 
LOCAL INFILE 'C:/Users/Administrator/Documents/GitHub/CSci226.Fall13/assignments/iris/iris.2D.csv'
INTO TABLE iris_2d
FIELDS TERMINATED BY ',';


select * from iris_2d;

select x,y from iris_2D where class = "Iris-setosa"
select * from iris_2D where class like "Iris-setosa%"
delete from iris_2d;
drop table iris_2d;

select class, avg(petallength), avg(petalwidth) from iris_2d 
group by class order by avg(petallength), avg(petalwidth);
