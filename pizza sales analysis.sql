create database pizza_db;
use pizza_db;
select database();

create table orders(
order_id int primary key,
date Date,
time Time
);

use pizza_db;
desc orders;
select * from orders;
select count(*) from orders;

create table order_details(
order_details_id int primary key auto_increment,
order_id int,
pizza_id varchar(50),
quantity  int,
total_price decimal(7,2)
);

desc order_details;
select * from order_details;
select count(*) from order_details;

create table pizzas(
pizza_id varchar(50) primary key,
pizza_name varchar(100),
size varchar(5),
price decimal(6,2)
);

select * from pizzas;

truncate table pizzas;

desc pizzas;
select * from pizzas;

select * from pizzas;
select * from order_details;

alter table pizzas
modify pizza_id int;

desc pizzas;
select * from pizzas;

select count(*) from pizzas;

create table pizza_types(
pizza_name varchar(100) primary key,
category varchar(50),
ingredients text
);

desc pizza_types;

select * from pizza_types;
truncate table pizza_types;

select * from pizza_types;

select count(*) from pizza_types;

use pizza_db;

select count(*) from pizza_types;

show tables;

select count(distinct order_id) as total_orders from orders;

desc order_details;


select round(sum(od.quantity * p.price),2) as total_revenue 
from order_details as od
join pizzas as p
on od.pizza_id = p.pizza_id;

select p.pizza_name, sum(od.quantity) as total_sold
from order_details as od
join pizzas as p
on od.pizza_id = p.pizza_id
group by p.pizza_name
order by total_sold desc
limit 5;

use pizza_db;

select pt.category , sum(od.quantity) as total_quantity
from order_details as od
join pizzas as p
on od.pizza_id = p.pizza_id 
left join pizza_types as pt
on p.pizza_name = pt.pizza_name
group by pt.category
order by total_quantity desc;


use pizza_db;

select sum(od.quantity) as total_pizza_sold 
from order_details as od;

select round(sum(od.quantity*p.price) / count(distinct o.order_id),2) as avg_order_value
from order_details as od
join orders as o 
on o.order_id = od.order_id
join pizzas as p
on p.pizza_id = od.pizza_id;

select pt.pizza_name, p.price from pizzas as p
join pizza_types as pt
on p.pizza_name = pt.pizza_name
order by p.price desc
limit 1;

select pt.pizza_name , p.price from pizzas as p
join pizza_types as pt
on p.pizza_name = pt.pizza_name
order by p.price asc
limit 1;

select pt.pizza_name , sum(od.quantity) as total_quantity
from order_details as od
join pizzas as p
on od.pizza_id = p.pizza_id
join pizza_types as pt
on pt.pizza_name = p.pizza_name
group by pt.pizza_name
order by total_quantity  desc
limit 5;

select pt.pizza_name , round(sum(od.quantity*p.price),2) as total_revenue
from order_details as od
join pizzas as p
on od.pizza_id = p.pizza_id
join pizza_types as pt
on p.pizza_name = pt.pizza_name
group by pt.pizza_name
order by total_revenue desc
limit 5;

select pt.category , sum(od.quantity) as total_quantity
from pizza_types as pt
join pizzas as p
on p.pizza_name = pt.pizza_name
join order_details as od
on od.pizza_id = p.pizza_id
group by pt.category;


select pt.category , round(sum(od.quantity*p.price),2) as revenue
from pizza_types as pt
join pizzas as p
on p.pizza_name = pt.pizza_name
join order_details as od
on od.pizza_id = p.pizza_id
group by pt.category;

select p.size, sum(od.quantity) as total_quantity
from pizzas as p
join order_details as od
on p.pizza_id = od.pizza_id
group by p.size
order by total_quantity desc;


select date, count(order_id ) as total_orders
from orders as o
group by date
order by date;

select date, count(order_id) as total_orders
from orders as o
group by date
order by total_orders desc
limit 1 ;

select pt.pizza_name , sum(od.quantity) as total_quantity
from order_details as od
join pizzas as p on od.pizza_id = p.pizza_id
join pizza_types as pt
on pt.pizza_name = p.pizza_name
group by pt.pizza_name
order by total_quantity asc
limit 1;


select pt.category, round(sum(od.quantity * p.price) * 100 /(select sum(od2.quantity * p2.price)
from order_details as od2
join pizzas as p2 on 
od2.pizza_id = p2.pizza_id) ,2) as
percentage_contribution from pizza_types as pt
join pizzas as p on pt.pizza_name = p.pizza_name
join order_details as od on p.pizza_id = od.pizza_id
group by pt.category;


select p.pizza_name, p.pizza_id  from pizzas as p
left join order_details as od
on p.pizza_id = od.pizza_id
where od.order_id is null;

select pt.category , coalesce(sum(od.quantity), 0) as total_quantity
from pizza_types as pt
left join pizzas as p
on pt.pizza_name = p.pizza_name
left join order_details as od
on p.pizza_id = od.pizza_id
group by pt.category;

select * from(select pt.category, pt.pizza_name as pizza_name, sum(od.quantity) as total_quantity,
rank() over (partition by pt.category
order by sum(od.quantity)desc) as rnk from order_details as od
join pizzas as p on p.pizza_id = od.pizza_id
join pizza_types as pt on pt.pizza_name = p.pizza_name
group by pt.category, pt.pizza_name) t
where rnk <= 3;

select date, count(order_id) as order_count
from orders
group by date
order by date;

select o.date , round(sum(od.quantity * p.price),2) as daily_revenue from orders o
join order_details as od on o.order_id = od.order_id
join pizzas as p on od.pizza_id = p.pizza_id 
group by o.date;

select pizza_name, category from pizza_types
where category = 'veggie'
union
select pizza_name , category from pizza_types
where category = 'chicken';

select pizza_name, category from pizza_types
where category = 'veggie'
union all
select pizza_name , category from pizza_types
where category = 'chicken';

select date, order_id  from orders
where month(date) = 1
union
select date, order_id from orders
where month(date) = 2;

select order_id , sum(quantity) as total_qty
from order_details as od
group by order_id
having sum(quantity)> (select avg(quantity) from order_details);


select avg(quantity) from order_details;

use pizza_db;

select * from orders;
select * from pizzas;
select * from pizza_types;
select * from order_details;

use pizza_db;