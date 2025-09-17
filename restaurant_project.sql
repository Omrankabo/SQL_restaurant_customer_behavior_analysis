-- Exploring tables 
-- amount of records in each table
SELECT count(menu_item_id)
FROM menu_items --32 items

-- Cheapest and most expensive item in the menu
select *
from menu_items
order by price asc  -- cheapest is Asain Edamame, the most expensive Italian Shrimp Scampi
 -- how to do this and select only one item where the price is the highest

-- how many items in the list are italian
select count(menu_item_id) from menu_items where category = 'italian' -- 9 items

-- update price type 
update menu_items set price = CAST(price as decimal)
-- how many items are there in each category
select category, count(menu_item_id) as count_of_dishes, avg(cast(price as int)) as avg_dish_price from menu_items group by category 

-- what date ranges I have in order_details table
select min(order_date) as min_date, max(order_date) as max_date from order_details -- it's 2023 period the first quarter with mm/dd/yy format

--how many orders and items in this date range where sold
select count(distinct order_id) 
from order_details  -- 5370

SELECT COUNT(order_details_id)
FROM order_details -- 12234 ordered items record


-- Which orders had the most number of items
select order_id, count(item_id) as num_items
from order_details
group by order_id
order by num_items desc

-- How many orders had more than 12 items

select count(order_id)
from 
	(select order_id, count(item_id) as num_items
	from order_details
	group by order_id) as aggregated_orders
where num_items > 12  -- 23 orders


-- Combine the tables in on single table
Select * 
from menu_items as mi
Left join
	order_details as od	
		on mi.menu_item_id = od.item_id

-- What were the least and most ordered itmes? and what category they were in?
Select mi.menu_item_id, mi.item_name, mi.category, count(od.order_id) as num_orders
from menu_items as mi
Left join
	order_details as od	
		on mi.menu_item_id = od.item_id
group by mi.menu_item_id, mi.item_name, mi.category
order by num_orders desc -- the most orderd items Hamburger - american 622 order, Edamame - asian 620 order, - Korean Beef Bowl - asian 588
-- the least ordered item Chicken tacos - maxican 123, Postsickers - asian 205, Cheese lasagna - italian 207

-- avg by category what category is ordered most frequantly
Select mi.category, avg( cast(od.order_id as int)) as avg_orders
from menu_items as mi
Left join
	order_details as od	
		on mi.menu_item_id = od.item_id
group by mi.category
order by avg_orders desc
-- Asian food has the most orders count but American & Italian have highest average amount of orders

-- What is the top 5 orders that spent the most amountof money?
Select top(5) od.order_id, sum( cast( mi.price as int)) as revenue, count(distinct od.item_id) as items_orderd
from menu_items as mi
Left join
	order_details as od	
		on mi.menu_item_id = od.item_id
group by od.order_id 
order by revenue desc -- the top 5 orders id with most revenue 440, 2075,1957,330,2675


-- what menu item has the most amount of revenue
Select top (5) mi.menu_item_id, mi.item_name, mi.category, (count(od.order_id) * mi.price) as revenue
from menu_items as mi
Left join
	order_details as od	
		on mi.menu_item_id = od.item_id
group by mi.menu_item_id, mi.item_name, mi.category, mi.price
order by revenue desc  -- Korean Beef bowl made the most revenue


--- What is in common between the top 5 menu items
Select top(5) od.order_id, sum( cast( mi.price as int)) as revenue
from menu_items as mi
Left join
	order_details as od	
		on mi.menu_item_id = od.item_id
group by od.order_id
order by revenue desc

--- 
select item_name, category, count(distinct order_id) as count_orders
from menu_items as mi
	Left join
		order_details as od	
			on mi.menu_item_id = od.item_id
	where 
	od.order_id in ( 440, 2075,1957 ,330 ,2675) 

group by item_name, category
order by count_orders desc