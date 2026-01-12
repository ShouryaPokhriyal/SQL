-----------------------Data Analytics------------------------------------------------------------------------------------------

-------BY:Shourya Pokhriyal
-------Created Date: 10/11/2025
-------Table used: Sales (containg the sales data) 

----SQL topics covered: Aggregation func, Windows Function, CTE, Partition by

----------------------------------------------------------------------------------------------------------------------------------

---Change over time trend
---(Measure)

------------Year having max sales of products -------------------
select sum(salesAmount) as Sales,
year(salesDate) as Year,
count(distinct Product) as Distinct_Product,
sum(QuantityOrdered) as QuantityOrdered
from Sales
group by year(salesDate)
order by sum(salesAmount) desc

------------Sales of products year wise -------------------
select product,
year(salesDate) as Year,
sum(salesAmount) as SalesAmount
from Sales
group by Product,year(salesDate)
order by year(salesDate)

---Cumulative Analysis
---(Aggregate data progreesively over time)
---Helps us understand if our bussiness is growing or not not over time

Select SYEAR,
Sales,
sum(sales) over (order by Syear) as Running_Total,
sum(Avg_Sales) over (order by Syear) as Running_Total_Avg
from
(
select sum(salesAmount) as Sales,
Avg(salesAmount) as Avg_Sales,
year(salesDate) as SYear
from Sales
group by year(salesDate)
) t
order by SYear 

---Performance Analysis
---(Comparing current value to target)
---Helps us measure the success

With Yearly_sales as 
(select Year(salesDate) as SYear,
Sum(salesAmount) as Sales,
Case when Product='Hand Cream' THEN 'Air Conditioner' ELSE Product END as Product ---change made only to check results
from 
Sales
group by Product,Year(salesDate)
)

select 
Syear,
Product,
Sales,
Avg(Sales) Over (Partition by Product) as Running_Avg,
Sales-Avg(Sales) Over (Partition by Product) as Avg_Diff,
Case when Sales-Avg(Sales) Over (Partition by Product)>0 THEN 'Above AVG'
WHEN Sales-Avg(Sales) Over (Partition by Product)=0 THEN 'SAME'
ELSE 'BELOW AVG' END as Checking_Avg,
Lag(Sales)Over (Partition by Product Order by Syear) as Py_sales
from Yearly_sales
order by Product,Syear

---Part to Whole Analysis
---(How Individual Category is Contribuiting to the whole)
---Helps us understand the key category

With Category_sales as 
(
Select Sum(salesAmount) as Sales,
Category
from 
Sales
group by Category
)

select 
Category,
Sales,
Sum(sales) Over() as OverallSales,
Round((Sales/Sum(sales) Over() )*100,2)as Perc_of_total
from Category_sales
order by sales desc

---Data Segmentation Analysis
---(Grouping data based on ranges)
---Helps us understand correlation btw measures

With Segmentation_sales as 
(
Select Category,
orderid,
case when SalesAmount<100 then 'Below 100'
when SalesAmount between 100 and 500 then '100-500'
when SalesAmount between 500 and 1000 then '500-1000'
else 'Above 1000'
END 
as 
Sales_cat
from 
Sales
group by Category,SalesAmount,orderid
)

select Category,
count(orderid) as Cat_Cnt,
Sales_cat
from Segmentation_sales
Group by Category,Sales_cat
order by Category














