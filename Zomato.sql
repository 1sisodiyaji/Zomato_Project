drop table if exists goldusers_signup;
CREATE TABLE goldusers_signup(userid integer,gold_signup_date date); 


INSERT INTO goldusers_signup(userid,gold_signup_date) 
 VALUES (1,'2017-12-07'),
(3,'2018-02-15');
use goldusers_signup;
select * from goldusers_signup;
drop table if exists users;
CREATE TABLE users(userid integer,signup_date date); 

INSERT INTO users(userid,signup_date) 
 VALUES (1,'2014-02-09'),
(2,'2015-05-01'),
(3,'2014-11-04');

drop table if exists sales;
CREATE TABLE sales(userid integer,created_date date,product_id integer); 

INSERT INTO sales(userid,created_date,product_id) 
 VALUES (1,'2001-11-01',2),
(3,'2012-11-12',1),
(2,'2020-07-12',3),
(1,'2019-02-28',2),
(1,'2018-09-23',3),
(3,'2016-10-20',2),
(1,'2016-09-11',1),
(1,'2016-06-10',3),
(2,'2017-12-09',1),
(1,'2003-11-03',2),
(1,'2016-11-15',1),
(3,'2016-10-13',1),
(3,'2016-07-15',2),
(3,'2015-11-16',2),
(2,'2015-08-15',2),
(2,'2015-10-18',3);


drop table if exists product;
CREATE TABLE product(product_id integer,product_name text,price integer); 

INSERT INTO product(product_id,product_name,price) 
 VALUES
(1,'p1',980),
(2,'p2',870),
(3,'p3',330);


select * from sales;
select * from product;
select * from goldusers_signup;
select * from users;

-- Now we will solve some problems related to these databse

-- Q1.  What is the total amount each customer spent on Zomato ?
select a.userid ,sum(b.price) total_amt_spent from sales a inner join product b on product_id = b.product_id
group by a.userid;           

-- Q2. How many days has each customer visited Zomato ?
select userid,count(distinct created_date) distinct_days from sales group by userid;

-- Q3.what was the first product ordered by ech customer ? 
select * from 
(select *,rank() over(partition by userid order by created_date) rnk from sales ) a where rnk = 1;

-- Q4. what is the most purchaesd item and how many times it is purchased  by all customer ?
select product_id,count(product_id) from sales group by product_id order by count(product_id) desc;

-- Q5. Which item is the most popular in each customer ?
select * from 
(select *, rank() over (partition by userid  order by cnt  desc) rnk from 
(select userid ,product_id, count(product_id) cnt from sales group by userid , product_id)a)b
where rnk =1;

