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
