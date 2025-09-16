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