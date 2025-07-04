-- Общее кол-во заказов и прибыль
SELECT 
	DISTINCT(COUNT(order_id)) AS total_orders,
    SUM(profit) AS total_profit
FROM data;

-- Средний чек
SELECT 
    ROUND(SUM(sales) / COUNT(DISTINCT order_id), 2) AS avg_order_value
FROM data;

-- Среднее время доставки
SELECT 
    ship_mode,
    AVG(ABS(DATEDIFF(ship_date, order_date))) AS avg_ship_days,
    SUM(sales) AS total_sales
FROM data
GROUP BY ship_mode
ORDER BY avg_ship_days DESC;

-- Сезонность продаж по месяцам, начиная с самого прибыльного
SELECT 
    MONTHNAME(order_date) AS month,
    SUM(sales) AS sales_by_month
FROM data
GROUP BY month
ORDER BY sales_by_month DESC;

-- Топ 10 самых прибыльных товаровов
SELECT
	product_name,
    category,
    SUM(profit) AS profit_of_product,
    SUM(SUM(profit)) OVER (PARTITION BY category) AS profit_of_category
FROM data
GROUP BY product_name, category
ORDER BY profit_of_product DESC
LIMIT 10;

-- Топ 5 убыточных позиций
SELECT 
    product_name,
    SUM(profit) AS total_lost
FROM data
WHERE profit < 0
GROUP BY product_name
ORDER BY total_lost
LIMIT 5;

-- Продажи по штатам, регионам
SELECT 
    state,
    region,
    SUM(sales) AS total_sales
FROM data
GROUP BY state, region
ORDER BY total_sales DESC;