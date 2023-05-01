# 1. JOIN CUSTOMER DETAILS TO THEIR ORDER ID

SELECT ord.order_id, CONCAT(cus.first_name, " ", cus.last_name) customers, cus.city, cus.state, ord.order_date
FROM sales_orders ord
JOIN sales_customers cus
ON ord.customer_id = cus.customer_id;

# 2. WE ALSO WANT TO JOIN THE QUANTITY AND TOTAL REVENUE THAT WAS MADE

SELECT ord.order_id, CONCAT(cus.first_name, " ", cus.last_name) customers, cus.city, cus.state, ord.order_date,
	   SUM(ite.quantity) AS total_unit,
       SUM(ite.quantity * ite.list_price) AS revenue
FROM sales_orders ord

JOIN sales_customers cus
ON ord.customer_id = cus.customer_id
JOIN sales_order_items ite
ON ord.order_id = ite.order_id

GROUP BY ord.order_id, customers, cus.city, cus.state, ord.order_date
ORDER BY ord.order_id;

# 3. WE WANT TO KNOW THE NAME OF THE PRODUCTS PURCHASED

SELECT ord.order_id, CONCAT(cus.first_name, " ", cus.last_name) customers, cus.city, cus.state, ord.order_date,
	   SUM(ite.quantity) AS total_unit,
       SUM(ite.quantity * ite.list_price) AS revenue,
       pro.product_name
FROM sales_orders ord

JOIN sales_customers cus
ON ord.customer_id = cus.customer_id
JOIN sales_order_items ite
ON ord.order_id = ite.order_id
JOIN production_products pro
ON ite.product_id = pro.product_id

GROUP BY ord.order_id, customers, cus.city, cus.state, ord.order_date, pro.product_name
ORDER BY ord.order_id;

# 4. WE WANT TO KNOW THE CATEGORY OF THE PRODUCTS PURCHASED

SELECT ord.order_id, CONCAT(cus.first_name, " ", cus.last_name) customers, cus.city, cus.state, ord.order_date,
	   SUM(ite.quantity) AS total_unit,
       SUM(ite.quantity * ite.list_price) AS revenue,
       pro.product_name,
       cat.category_name
FROM sales_orders ord

JOIN sales_customers cus
ON ord.customer_id = cus.customer_id
JOIN sales_order_items ite
ON ord.order_id = ite.order_id
JOIN production_products pro
ON ite.product_id = pro.product_id
JOIN production_categories cat
ON pro.category_id = cat.category_id

GROUP BY ord.order_id, customers, cus.city, cus.state, ord.order_date, pro.product_name,
	     cat.category_name
ORDER BY ord.order_id;

# 5. WE WANT TO KNOW THE STORE THE ORDER TOOK PLACE IN

SELECT ord.order_id, CONCAT(cus.first_name, " ", cus.last_name) customers, cus.city, cus.state, ord.order_date,
	   SUM(ite.quantity) AS total_unit,
       SUM(ite.quantity * ite.list_price) AS revenue,
       pro.product_name,
       cat.category_name,
       stores.store_name
FROM sales_orders ord

JOIN sales_customers cus
ON ord.customer_id = cus.customer_id
JOIN sales_order_items ite
ON ord.order_id = ite.order_id
JOIN production_products pro
ON ite.product_id = pro.product_id
JOIN production_categories cat
ON pro.category_id = cat.category_id
JOIN sales_stores stores
ON ord.store_id = stores.store_id

GROUP BY ord.order_id, customers, cus.city, cus.state, ord.order_date, pro.product_name,
	     cat.category_name, stores.store_name
ORDER BY ord.order_id;

# 6. WE WANT TO KNOW THE SALES REP THAT MADE THE SALES

SELECT ord.order_id, CONCAT(cus.first_name, " ", cus.last_name) customers, cus.city, cus.state, ord.order_date,
	   SUM(ite.quantity) AS total_unit,
       SUM(ite.quantity * ite.list_price) AS revenue,
       pro.product_name,
       cat.category_name,
       stores.store_name,
       CONCAT(staf.first_name, " " , staf.last_name) sales_rep
FROM sales_orders ord

JOIN sales_customers cus
ON ord.customer_id = cus.customer_id
JOIN sales_order_items ite
ON ord.order_id = ite.order_id
JOIN production_products pro
ON ite.product_id = pro.product_id
JOIN production_categories cat
ON pro.category_id = cat.category_id
JOIN sales_stores stores
ON ord.store_id = stores.store_id
JOIN sales_staffs staf
ON ord.staff_id = staf.staff_id

GROUP BY ord.order_id, customers, cus.city, cus.state, ord.order_date, pro.product_name,
	     cat.category_name, stores.store_name, sales_rep
ORDER BY ord.order_id;

# The Extracted data is clean and we can proceed to excel

