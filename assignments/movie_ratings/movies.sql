create database movies;
use movies

drop table movie_list;
create table movie_list (mid int key, myear year, mname varchar(132));

/* laptop */
LOAD DATA 
LOCAL INFILE 'C:/Users/Administrator/Documents/GitHub/CSci226.Fall13/assignments/movie_ratings/movie_list.1.csv' 
INTO TABLE movie_list
FIELDS TERMINATED BY ']';

/* pc */
LOAD DATA 
LOCAL INFILE 'D:/Documents/GitHub/CSci226.Fall13/assignments/movie_ratings/movie_list.1.csv' 
INTO TABLE movie_list
FIELDS TERMINATED BY ']';




delete from movie_list;
select * from movie_list limit 100;

select * from movie_list where mname like "%Avengers%";
select * from movie_list where mname like "%Batman%";
select * from movie_list where mname like "%Cat%";
select * from movie_list where mname like "%Jungle%";

select * from movie_list where mname like "Alice in Wonderland_" or
   mname like "%Batman%"

select * from movie_list where myear = 1993

select * from movie_list where mid in (99, 313, 420, 465, 588)

select count(*) from ratings where m99 <> 0

create table movie_ratings(pid int, mid int, rating int, key (pid, mid))

insert into movie_ratings (select pid, 99, m99 as rating from ratings where m99 <>0 )
select * from movie_ratings where mid=99

insert into movie_ratings (select pid, 313, m313 as rating from ratings where m313 <>0 );
insert into movie_ratings (select pid, 420, m420 as rating from ratings where m420 <>0 );
insert into movie_ratings (select pid, 465, m465 as rating from ratings where m465 <>0 );
insert into movie_ratings (select pid, 588, m588 as rating from ratings where m588 <>0 );

select count(*) from movie_ratings

select (select mname from movie_list where mid=99) AS 'Movie', 
count(*) as 'number of reviews', avg(rating) as 'avg rating' from movie_ratings where mid=99 UNION
select (select mname from movie_list where mid=313) AS 'Movie', 
count(*) as 'number of reviews', avg(rating) as 'avg rating' from movie_ratings where mid=313 UNION 
select (select mname from movie_list where mid=420) AS 'Movie', 
count(*) as 'number of reviews', avg(rating) as 'avg rating' from movie_ratings where mid=420 UNION 
select (select mname from movie_list where mid=465) AS 'Movie', 
count(*) as 'number of reviews', avg(rating) as 'avg rating' from movie_ratings where mid=465 UNION 
select (select mname from movie_list where mid=588) AS 'Movie', 
count(*) as 'number of reviews', avg(rating) as 'avg rating' from movie_ratings where mid=588 ;

select a.pid, a.rating, b.rating, c.rating, d.rating,
e.rating  from movie_ratings a, 
  movie_ratings b, movie_ratings c, movie_ratings d, movie_ratings e
where a.pid=b.pid and b.pid =c.pid and c.pid = d.pid and d.pid = e.pid
and a.mid = 99
and b.mid = 313
and c.mid = 420
and d.mid = 465
and e.mid = 588

select *  from movie_ratings a, 
  movie_ratings b, movie_ratings c, movie_ratings d, movie_ratings e
where a.pid=b.pid and b.pid =c.pid and c.pid = d.pid and d.pid = e.pid
and a.mid = 99
and b.mid = 313
and c.mid = 420
and d.mid = 465
and e.mid = 588

delete from movie_ratings
/* pc */
LOAD DATA 
LOCAL INFILE 'D:/Documents/GitHub/CSci226.Fall13/assignments/movie_ratings/ratings.tabledata.csv' 
INTO TABLE movie_ratings
FIELDS TERMINATED BY ',';

alter table movie_ratings add index (pid);
alter table movie_ratings add index (mid);

select count(*) from movie_ratings a, movie_ratings b where
   a.mid = b.mid and
   a.rating = b.rating and
   a.pid < b.pid;