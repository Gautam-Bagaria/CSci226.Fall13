create database movies;
use database movies;

drop table movie_list;
create table movie_list (mid int key, myear year, mname varchar(132));

LOAD DATA 
LOCAL INFILE 'C:/Users/Administrator/Documents/GitHub/CSci226.Fall13/assignments/movie_ratings/movie_list.1.csv' 
INTO TABLE movie_list
FIELDS TERMINATED BY ']';

delete from movie_list;
select * from movie_list limit 100;