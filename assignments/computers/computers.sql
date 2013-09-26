create database computers;
use computers;
create table product (maker char(1), model int, ctype varchar(10));
insert into product values
('A',	1001, 'pc'),
('A',	1002,	'pc'),
('A',	1003,	'pc'),
('A',2004  ,'laptop'),
('A',2005  ,'laptop'),
('A',2006  ,'laptop'),
('B',	1004, 'pc'),
('B',	1005, 'pc'),
('B',	1006, 'pc'),
('B',	2007  ,'laptop'),
('C',	1007, 'pc'),
('D',	1008, 'pc'),
('D',	1009, 'pc'),
('D',	1010, 'pc'),
('D',	3004, 'printer'),
('D',	3005, 'printer'),
('E',	1011, 'pc'),
('E',	1012, 'pc'),
('E',	1013, 'pc'),
('E',	2001  ,'laptop'),
('E',	2002  ,'laptop'),
('E',	2003  ,'laptop'),
('E',	3001, 'printer'),
('E',	3002, 'printer'),
('E',	3003, 'printer'),
('F',	2008  ,'laptop'),
('F',	2009  ,'laptop'),
('G',	2010  ,'laptop'),
('H',	3006, 'printer'),
('H',	3007, 'printer');

create table pc (model int,	speed float, ram int, hd int, price int);
insert into pc values
(1001,	2.66,	1024,	250,	2114),
(1002,	2.10,	512,	250,	995),
(1003,	1.42,	512,	80,	    478),
(1004,	2.80,	1024,	250,	649),
(1005,	3.20,	512,	250,	630),
(1006,	3.20,	1024,	250,	1049),
(1007,	2.20,	1024,	250,	510),
(1008,	2.20,	2048,	250,	770),
(1009,	2.00,	1024,	250,	650),
(1010,	2.80,	2048,	300,	770),
(1011,	1.86,	2048,	160,	959),
(1012,	2.80,	1024,	160,	649),
(1013,	3.06,	512,	80,	    529);

create table laptop (model int,	speed float, ram int, hd int,  screen float, price int);
insert into laptop values
(2001,	2.00,	2048,	240,	20.1,	3673),
(2002,	1.73,	1024,	80,	17.0,	949),
(2003,	1.80,	512,	60,	16.4,	549),
(2004,	2.00,	512,	60,	13.3,	1150),
(2005,	2.16,	1024,	120,	17.0,	2500),
(2006,	2.00,	2048,	80,	15.4,	1700),
(2007,	1.83,	1024,	120,	13.3,	1429),
(2008,	1.60,	1024,	100,	15.4,	900),
(2009,	1.60,	512,	80,	14.1,	680),
(2010,	2.00,	2048,	160,	15.4,	2300)

create table printer (model int,	color boolean,	ctype varchar(10),	price int);
insert into printer values
(3001,	TRUE,	'ink-jet',	99),
(3002,	FALSE,	'laser',	239),
(3003,	TRUE,	'laser',	899),
(3004,	TRUE,	'ink-jet',	120),
(3005,	FALSE,	'laser',	120),
(3006,	TRUE,	'ink-jet',	100),
(3007,	TRUE,	'laser',	200);

select maker from product, laptop 
   where product.model = laptop.model;

select distinct(maker) from product
   where product.ctype = 'laptop'
      and not maker in 
(select maker from product
   where product.ctype = 'pc');

# this is a comment
select product.model, pc.model, price/100.0 as 'price', 'PC' as ctype from product, pc
   where product.maker = 'B'
 and product.model = pc.model 
union
select product.model, laptop.model, price, 'laptop' as ctype from product, laptop
   where product.maker = 'B'
 and product.model = laptop.model 
union
select product.model, printer.model, price, 'printer' as ctype from product, printer
   where product.maker = 'D'
 and product.model = printer.model; 


select maker from product natural join laptop where price < 1000

select product.maker from product,  
     (select maker from product natural join laptop where price < 1000) B
  where product.maker = B.maker
    and product.ctype = 'pc';

select maker from product natural join laptop 
   where price < 1000
     and maker in 
		(select maker from product where ctype = 'pc');

drop table manf;
create table manf (maker char(1) key, makername varchar(30));
insert into manf values ('A', 'The A-Company'),
  ('B', 'The B-Company'),
  ('C', 'The C-Company'),
  ('D', 'The D-Company'),
  ('E', 'The E-Company'),
  ('F', 'The F-Company'),
  ('G', 'The G-Company'),
  ('H', 'The H-Company');

select maker from manf
   where
      maker in 
        (select maker from product natural join laptop where price < 1000)  
      and maker in 
		(select maker from product where ctype = 'pc');

select maker from product   
  where product.ctype = 'laptop'      
    and maker not in 
   (select maker from product where product.ctype = 'pc');

select maker from manf   
  where 
    maker in 
      (select maker from product where product.ctype = 'laptop')
    and maker not in 
      (select maker from product where product.ctype = 'pc');

select maker from product   
  where ctype = 'laptop'      
    and maker not in 
   (select maker from product where ctype = 'pc')
  group by maker;

SELECT A.maker FROM product A where ctype='pc'
  AND EXISTS
      (SELECT B.maker FROM product B 
         NATURAL JOIN laptop  WHERE price < 1000 
         AND A.maker = B.maker ) ;


SELECT A.maker FROM product A where ctype='pc'
into outfile '/tmp/test.csv'
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
;

select product.model, pc.model, price/100.0 as 'price', 'PC' as ctype from product, pc
   where product.maker = 'B'
 and product.model = pc.model 
union
select product.model, laptop.model, price, 'laptop' as ctype from product, laptop
   where product.maker = 'B'
 and product.model = laptop.model 
union
select product.model, printer.model, price, 'printer' as ctype from product, printer
   where product.maker = 'D'
 and product.model = printer.model
into outfile '/tmp/test1.csv'
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
;
