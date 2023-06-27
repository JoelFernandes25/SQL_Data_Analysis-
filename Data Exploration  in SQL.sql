-- Look at the tables 
SHOW TABLES;

-- Selecting the data
SELECT * FROM flipkart;

-- 1. What are the popular brands in the dataset?

SELECT BRAND , COUNT(BRAND) brands 
FROM flipkart
GROUP BY brand
ORDER BY brands DESC;

-- Insights :
-- Popular brands in the dataset: Realme, Samsung, Xiaomi, Apple, Poco
-- Realme has 138 models, Samsung has 119 models, Xiaomi has 61 models, Apple has 56 models, and Poco has 56 models.
 
 
-- 2. What model is sold the most?

SELECT model,count(sales) Total
FROM flipkart 
GROUP BY model
ORDER BY Total DESC;

-- Insights : 
-- Based on the data,the model sold the most is "iPhone XR" with a sales count of 18.


-- 3. Which top 5 models have the highest sales price?

SELECT model, sales_price
FROM flipkart 
GROUP BY model
ORDER BY sales_price DESC
LIMIT 5;

-- Insights :
-- Models with the highest sales prices are Galaxy Z Fold3 5G, Galaxy Z Flip3 5G, Galaxy Note 20 Ultra 5G, Galaxy Note 20, and Galaxy Fold 2. 
-- These models are positioned in the premium segment and offer advanced features and innovative designs.


-- 4. What is the average discount percentage for models with a battery capacity greater than 3000 mAh? 
 
 SELECT model, AVG(discount_percent) AS Average_discount_percent
FROM flipkart
WHERE battery_capacity > 3000
GROUP BY model
ORDER BY Average_discount_percent DESC;

-- Insights :
-- The avg discount percentage on models with battery capacity greater than 3000 mAh is approximately 9.57%. 
-- This indicates that, on average, customers can avail a discount of around 9.57% on smartphones with higher battery capacities


-- 5.  What is the average battery capacity for each top 5 brand? 

SELECT brand, ROUND(AVG(battery_capacity)) Average
FROM flipkart 
GROUP BY brand
ORDER BY Average DESC
LIMIT 5;

-- Insights :
-- It indicates that Poco has the highest average battery capacity among the brands in the dataset, 
-- Followed by Samsung, Realme, Xiaomi, and Apple. 
-- Customers who prioritize longer battery life may find Poco smartphones more appealing due to their higher average battery capacity.


-- 6. Are there any specific colors that are more popular among customers?

SELECT base_color, count(sales) Total
FROM flipkart
WHERE base_color <> 'Others'
GROUP BY base_color
ORDER BY Total DESC;

-- Insights :
-- Blue and black are the most popular choices, followed by white and silver. 
-- It's interesting to note that some customers also opt for vibrant colors like green and red. 
-- The popularity of certain colors can vary based on personal preferences, trends, and cultural factors.


-- 7. Calculate the average sales price for each color.

SELECT base_color, AVG(sales_price) Average_price
FROM flipkart
GROUP BY base_color
ORDER BY Average_price DESC;

-- Insights :
-- Purple and bronze have the highest average sales prices
-- indicating that smartphones in these colors may be associated with higher-end models or limited edition versions. 
-- On the other hand, gold has a relatively lower average sales price.


-- 8. Calculate the total sales for each processor type.

SELECT processor, SUM(sales) Total_Sales
FROM flipkart
GROUP BY processor
ORDER BY Total_sales DESC;

-- Insights :
-- The data shows that Qualcomm and MediaTek processors have the highest total sales, indicating their popularity among customers. 
-- Exynos processors also contribute significantly to the total sales. 
-- The sales for Water, Ceramic, iOS, and Others are relatively lower


-- 9. Which models have the highest ratings and number of ratings?

SELECT model, ratings, num_of_ratings
FROM flipkart
GROUP BY model
ORDER BY ratings DESC, num_of_ratings DESC;

-- Insights :
-- Phone XR: 4.6 rating with 5366 ratings
-- Galaxy S10: 4.6 rating with 1910 ratings
-- iPhone 12: 4.6 rating with 745 ratings
-- These models have received high ratings from customers and have a significant number of ratings, indicating their popularity and customer satisfaction.


-- 10. Calculate the average battery capacity for models with a rating above 4.5.

SELECT model, ratings,AVG(battery_capacity) Averaged
FROM flipkart
WHERE ratings > 4.5
GROUP BY model
ORDER BY ratings DESC;

-- Insights :
-- Galaxy S10 has the highest average battery capacity 


-- 11. Is there any correlation between RAM size and sales price?

SELECT
(SUM(ram * sales_price) - COUNT(*) * AVG(ram) * AVG(sales_price)) /
(SQRT((SUM(ram * ram) - COUNT(*) * AVG(ram) * AVG(ram)) *
(SUM(sales_price * sales_price) - COUNT(*) * AVG(sales_price) * AVG(sales_price))))
AS correlation_coefficient
FROM flipkart;

-- Insights :
-- Based on the given correlation coefficient of 0.339, there is a positive correlation between RAM size and sales price. 
-- However, the strength of the correlation is moderate. 


-- 12. What is the overall average rating for each brand?
 
SELECT brand, ROUND(AVG(num_of_ratings))  Average_Ratings
FROM flipkart
GROUP BY brand
ORDER BY Average_Ratings DESC;

-- Insights :
-- Xiaomi, Poco, Realme have the highest average ratings 


-- 13. Are there any specific processors that are more commonly used across different brands and models?

SELECT brand, model, processor, COUNT(processor) Counted
FROM flipkart
GROUP BY processor
ORDER BY Counted DESC;

-- Insights :
-- Qualcomm: Used in Poco M3.
-- MediaTek: Used in Poco C3.
-- Exynos: Used in Samsung Galaxy F12.
-- Ceramic: Used in Apple iPhone 12 Mini.
-- iOS: Used in Apple iPhone XR.
-- Water: Used in Apple iPhone SE.
-- These are the specific processors mentioned for each brand and mode

-- 14. Is there any correlation between the display size and battery capacity?

SELECT 
(SUM(display_size * battery_capacity) - COUNT(*) * AVG(display_size) * AVG(battery_capacity)) /
(SQRT((SUM(display_size * display_size) - COUNT(*) * AVG(display_size) * AVG(display_size)) *
(SUM(battery_capacity * battery_capacity) - COUNT(*) * AVG(battery_capacity) * AVG(battery_capacity))))
AS correlation_coefficient
FROM flipkart;

-- Insights :
--  There is a moderate positive correlation (0.662) between the display size and battery capacity. 
-- This suggests that, in general, as the display size increases, the battery capacity tends to increase as well.


-- 15. What is the overall average sales price for each brand?

SELECT brand, ROUND(AVG(sales)) Average_Sales
FROM flipkart 
GROUP BY brand
ORDER BY Average_Sales DESC ;

-- Insights :
-- Xiaomi has the highest average sales price at 61, followed by Poco at 44 and Realme at 31. 
-- Apple has an average sales price of 19, while Samsung has the lowest average price at 11

-- 16. Are there any brands that offer a wide range of models with varying features?

SELECT brand, 
VARIANCE(screen_size) AS screen_size_variance,
VARIANCE(ROM) AS ROM_variance,
VARIANCE(RAM) AS RAM_variance,
VARIANCE(display_size) AS display_size_variance,
VARIANCE(num_rear_camera) AS num_rear_camera_variance,
VARIANCE(num_front_camera) AS num_front_camera_variance,
VARIANCE(battery_capacity) AS battery_capacity_variance
FROM flipkart
GROUP BY brand
HAVING COUNT(DISTINCT model) > 1;

-- Insights :
-- There are brands that offer a wide range of models with varying features. Realme, Samsung,
-- Xiaomi are the brands that have a higher number of models and show a significant variation in average sales prices
-- Indicating a diverse product lineup with varying features and price points.


-- 17. Are there any models with a large difference between the sales price and the discounted price?

SELECT model, sales_price, discount_percent, (sales_price - (sales_price * discount_percent))  Customer_Paid
FROM flipkart
WHERE discount_percent > 0
ORDER BY Customer_Paid DESC;

-- Insights :
-- There are several models with a large difference between the sales price and the discounted price. Here are some examples:
-- Galaxy Z Fold3 5G: Sales Price - 157,999 / Discounted Price - 139,039.12
-- Galaxy Fold 2: Sales Price - 149,999 / Discounted Price - 118,499.21
-- Galaxy Note 20 Ultra 5G: Sales Price - 91,999 / Discounted Price - 73,599.2
-- iPhone 12 Mini: Sales Price - 72,149 / Discounted Price - 61,326.65


-- 18. Are there any specific combinations of RAM and ROM sizes that are more popular among customers?

SELECT RAM, ROM, COUNT(*) Popularity
FROM flipkart
GROUP BY RAM, ROM
ORDER BY popularity DESC;

-- Insights :
-- Based on the data, we can identify a few combinations of RAM and ROM sizes that appear to be more popular among customers:
-- 4GB RAM + 64GB ROM: This combination has the highest count of 93, indicating that it is a popular choice among customers.
-- 6GB RAM + 128GB ROM: This combination is also quite popular, with a count of 82.
-- 8GB RAM + 128GB ROM: Another popular combination, with a count of 73.
-- 3GB RAM + 32GB ROM: This combination has a count of 42, suggesting it is a relatively common choice among customers.


-- 19. Which brand has the highest number of models?

WITH mytable
AS
(
SELECT brand, COUNT(model) Model, DENSE_RANK() OVER( ORDER BY COUNT(model)DESC) as Counted
FROM flipkart
GROUP BY brand
)
SELECT brand, Model, Counted
 FROM mytable
WHERE Counted = 1;

-- Insights :
-- Based on the data, Realme has the highest number of models with a count of 138.


-- 20. Rank the brands based on the total number of ratings

SELECT brand, SUM(ratings) AS Total, DENSE_RANK() OVER (ORDER BY SUM(ratings) DESC) AS Ranked
FROM flipkart
GROUP BY brand;

-- Insights :
-- Samsung, Xiaomi, Apple, and Poco also occupy prominent positions in terms of total ratings, indicating their popularity. 
-- These brands have successfully cultivated a loyal customer base


-- 21. What is the highest-rated model for each brand?

SELECT brand, model, DENSE_RANK() OVER(ORDER BY SUM(ratings)) Rated
FROM flipkart
GROUP BY brand;

-- Insights :
-- The highest-rated models for each brand indicate successful and well-received devices. Poco's C3, Apple's iPhone SE, Xiaomi's Redmi 9A, Samsung's Galaxy F22
-- They all received positive feedback from customers, suggesting that these models offer desirable features, performance, or value for money. 


-- 22. Find the models with the highest number of front cameras using RANKING Function and display models ranked 1 for each brand
 
WITH temp_table
AS
(
SELECT brand, model, num_front_camera, DENSE_RANK() OVER(PARTITION BY brand ORDER BY num_front_camera DESC) Camera_ranked
FROM flipkart
GROUP BY model
)
SELECT brand, model, num_front_camera, Camera_ranked
FROM temp_table
WHERE Camera_ranked = 1
ORDER BY num_front_camera DESC ;

-- Insights :
-- Samsung: Galaxy Fold 2
-- Poco: X2
-- Realme: X3 SuperZoom
-- Xiaomi: Redmi Note 6 Pro
-- Apple: iPhone SE
-- These models stand out for offering multiple front cameras, which can provide enhanced selfie capabilities 
--  Customers who prioritize front camera performance may find these models appealing due to their advanced camera.


-- 23. How many models have a higher sales price than the average sales price for their respective brands?

SELECT COUNT(*) AS num_models
FROM flipkart f
WHERE f.sales_price > (
  SELECT AVG(sales_price)
  FROM flipkart
  WHERE brand = f.brand
  GROUP BY brand
);

-- Insights :
-- There are 159 models that have a higher sales price than the average sales price for their respective brands. 
-- This indicates that there is a significant number of models


-- 24. Rank the brands based on the average sales price of their models.

SELECT brand, sales_price, model, DENSE_RANK() OVER( ORDER BY AVG(sales_price)) Average_Price
FROM flipkart
GROUP BY brand;

-- Insights :
-- Apple has the highest average sales price, indicating a focus on premium pricing.
-- Samsung ranks second, offering devices in a higher price range.
-- Xiaomi and Realme target more price-conscious consumers with lower average sales prices.
-- Poco strikes a balance between competitive features and affordability.


-- 25. Which brand have the Lowest Rating for its respective model ?

WITH rating_table 
AS
(
SELECT brand, model, ratings, DENSE_RANK() OVER (PARTITION BY brand ORDER BY ratings DESC) Ranking
FROM flipkart
GROUP BY brand, model, ratings
)
SELECT brand, model, ratings, Ranking
FROM rating_table
WHERE Ranking = (SELECT MAX(Ranking) FROM rating_table);

-- Insights :
-- The brand with the lowest rating for its respective model is Samsung, specifically for the Samsung Galaxy Fold 2.


-- 26. Find the brands that have a significant difference in sales prices between their highest-rated and lowest-rated models.

WITH rating_table 
AS 
(
SELECT brand, model, ratings, sales_price,RANK() OVER (PARTITION BY brand ORDER BY ratings DESC) AS rating_rank
FROM flipkart
)
SELECT brand, MAX(sales_price) - MIN(sales_price) AS price_difference
FROM rating_table
WHERE rating_rank = 1
GROUP BY brand
HAVING price_difference > 0;

-- Insights :
-- The brands Apple, Realme, and Xiaomi show a significant difference in sales prices between their highest-rated and lowest-rated models. 
-- This suggests that these brands offer a diverse range of pricing options, catering to different customer preferences and budgets. 


-- 27. Rank the models within each brand based on the difference between their sales price and discounted price.

SELECT brand, model, sales_price, sales_price - (discount_percent * sales_price) Difference, 
DENSE_RANK() OVER(PARTITION BY brand ORDER BY sales_price DESC) Rated
FROM flipkart
GROUP BY model;

-- Insights :
-- Apple's iPhone 12 and iPhone 12 Mini, as well as Poco's F3 GT and F1, stand out for offering significant savings by discounted prices. 
-- Realme and Samsung models also show varied price differences, suggesting potential savings across different price ranges.

-- 28. Find the models with the highest sales within each brand, ranked by their sales price 
-- Rank the brands based on the total number of sales.

WITH brand_sales 
AS 
(
SELECT brand, SUM(sales) AS total_sales, DENSE_RANK() OVER (ORDER BY SUM(sales) DESC) AS Brand_Rank
FROM flipkart
GROUP BY brand
)
SELECT brand, total_sales, Brand_Rank
FROM brand_sales;

-- Insights :
-- Realme leads the pack with the highest total number of sales, followed by Xiaomi, Poco, Samsung, and Apple. 


-- 29. Rank the brands based on the average battery capacity of their models.

SELECT brand, model, AVG(battery_capacity) Average, 
DENSE_RANK() OVER(PARTITION BY brand ORDER BY AVG(battery_capacity)DESC) Ranked
FROM flipkart
GROUP BY model;

-- Insights :
-- Apple ranks first, followed by Poco, Realme, Samsung, and Xiaomi. Apple's iPhones consistently offer higher average battery capacities
-- While Poco and Realme demonstrate a strong focus on providing models with larger battery capacities.
 -- Samsung and Xiaomi also offer competitive battery capacities across their range of smartphones. 
 

 
 
