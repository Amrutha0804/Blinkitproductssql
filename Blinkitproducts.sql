SELECT * FROM blinkit_products

SELECT COUNT(*) FROM blinkit_products

--- Basic statistics based on product name and category

SELECT product_name,category,
    ROUND(MIN(price),2) AS MinPrice, 
    ROUND(MAX(price),2) AS MaxPrice, 
    ROUND(AVG(price),2) AS AvgPrice
FROM blinkit_products
GROUP BY product_name,category


--Products with highest margin%

SELECT TOP 10 
    product_name, brand, category, margin_percentage
FROM blinkit_products
ORDER BY margin_percentage DESC;


---Average margin by category

SELECT category, ROUND(AVG(margin_percentage),2) AS AvgMargin
FROM blinkit_products
GROUP BY category
ORDER BY AvgMargin DESC


---Average discount % by brand

SELECT 
    brand,
    ROUND(AVG((mrp - price) * 100.0 / mrp),2) AS AvgDiscountPct
FROM blinkit_products
GROUP BY brand 
ORDER BY AvgDiscountPct


---Products at stockout risk

SELECT 
    product_id, product_name, brand, min_stock_level, max_stock_level
FROM blinkit_products
WHERE min_stock_level < (0.2 * max_stock_level);

--- Adding a new column to show the stock risk as a flag


SELECT 
    product_id,
    product_name,
    brand,
    min_stock_level,
    max_stock_level,
    CASE 
        WHEN min_stock_level < 0.2 * max_stock_level THEN 'High Risk'
        WHEN min_stock_level < 0.5 * max_stock_level THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS Stock_Risk_Flag
FROM blinkit_products

---Calculating the high risk category products

SELECT 
    category,
    COUNT(*) AS TotalProducts,
    SUM(CASE WHEN min_stock_level < (0.2 * max_stock_level) THEN 1 ELSE 0 END) AS HighRiskProducts,
    ROUND(
        100.0 * SUM(CASE WHEN min_stock_level < (0.2 * max_stock_level) THEN 1 ELSE 0 END) 
        / COUNT(*), 2
    ) AS HighRiskProductPct
FROM blinkit_products
GROUP BY category
ORDER BY HighRiskProductPct DESC;


---Potential revenue capacity by category

SELECT 
    category,
    ROUND(SUM(price * max_stock_level),2) AS PotentialRevenue
FROM blinkit_products
GROUP BY category
ORDER BY PotentialRevenue DESC;


---Average shelf life by category

SELECT category, 
       ROUND(AVG(shelf_life_days),0) AS AvgShelfLife
   FROM blinkit_PRODUCTS
GROUP BY category
ORDER BY AvgShelfLife


---Rank products by margin in each category

SELECT 
    category,
    product_name,
    margin_percentage,
    RANK() OVER (PARTITION BY category ORDER BY margin_percentage DESC) AS MarginRank
FROM blinkit_products;

---% contribution of each product to category revenue

SELECT TOP 5
    category,
    product_name,
    price * max_stock_level AS ProductRevenue,
    ROUND(
      (price * max_stock_level * 100.0) 
      / SUM(price * max_stock_level) OVER (PARTITION BY category), 2
    ) AS RevenuePct
FROM blinkit_products
ORDER BY RevenuePct DESC

