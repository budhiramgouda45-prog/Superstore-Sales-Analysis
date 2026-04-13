create database Superstore_Sales_Analysis

exec sp_rename 'superstore_sales_file','superstore_sales_analysis'

select * from superstore_sales_analysis

--Total_Order
select count(distinct Order_ID) as Total_Order from superstore_sales_analysis


--Total Sales
Select Sum(sales) as Total_Sales from superstore_sales_analysis

--Average Order value
select 
cast(sum(Sales)*1.0/count(distinct Order_ID) as decimal(10,2))
as avg_order_value
from superstore_sales_analysis

--Total Customer
select count(distinct Customer_ID) as Total_Customer from superstore_sales_analysis

--Monthly sales
select 
month(Order_Date) as Month_Number,
datename(month,Order_Date) as Month_Name,
sum(Sales) as Total_Sales
from superstore_sales_analysis
group by month(Order_Date),datename(month,Order_Date)
Order by Month_Number

--Monthly Order
select top 5
datename(month,Order_Date) as Month_Name,
count(distinct Order_ID) Total_Order
from superstore_sales_analysis 
group by month(Order_Date),datename(month,Order_Date)
Order by Total_Order desc

-- Ship_Mode wise Total_Sales
select Ship_Mode,
sum(Sales) as Total_Sales 
from superstore_sales_analysis
group by Ship_Mode order by Total_Sales desc

--top 10 customer based on sales
select top 10 
Customer_Name,
sum(Sales) as Total_Sales 
From superstore_sales_analysis group by Customer_Name order by Total_Sales desc

--Segment wise Total_Sales
select 
Segment,
sum(Sales) as Total_Sales 
from superstore_sales_analysis 
group by Segment 
order by Total_Sales desc

--Top 5 City by sales
select 
top 5
City,
sum(Sales) as Total_Sales
from 
superstore_sales_analysis 
group by City
order by Total_Sales desc


--Region wise sales
select 
Region,
sum(Sales) as Total_Sales 
from superstore_sales_analysis 
group by Region 
order by Total_Sales desc

---Category wise Sales
select Category,
sum(Sales) as Total_Sales 
from superstore_sales_analysis 
group by Category 
order by Total_Sales desc


--Top 5 Product

select top 5
Product_Name,
sum(Sales) as Total_Sales 
from superstore_sales_analysis
group by Product_Name
order by Total_Sales desc


--Repeat Customer
SELECT 
Customer_ID,
COUNT(DISTINCT Order_ID) AS Total_Orders
FROM superstore_sales_analysis
GROUP BY Customer_ID
HAVING COUNT(DISTINCT Order_ID) > 1;

--Top 5 State
Select top 5
State,
sum(Sales) as Total_Sales 
from superstore_sales_analysis group by State
Order by Total_Sales desc

--sub-category wise sales
select 
Sub_Category,
sum(Sales) as Total_Sales 
from superstore_sales_analysis
group by Sub_Category
order by Total_Sales desc

--MoM Growth

with MonthlySales as 
(SELECT 
YEAR(Order_Date) AS Year,
MONTH(Order_Date) AS Month,
SUM(Sales) AS Current_Month_Sales
FROM superstore_sales_analysis
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
)
select 
Year,
Month,
Current_Month_Sales,
lag(Current_Month_Sales) over(order by Year,Month) as Previous_Month
from MonthlySales;




