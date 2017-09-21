USE AdventureWorks2012; /*Set current database*/


/*1, Display the total amount collected from the orders for each order date. */
select OrderDate,
	sum(TotalDue) as Daily_Amount,
	count(SalesOrderID) as Number_of_Orders
from sales.SalesOrderHeader
group by OrderDate
order by sum(TotalDue) desc;


/*2, Display the total amount collected from selling the products, 774 and 777. */
select ProductID,
	sum(LineTotal) as Total_Amount,
	avg(UnitPrice) as Avg_Unit_Price,
	max(UnitPrice) as Max_Unit_Price,
	min(UnitPrice) as Min_Unit_Price,
	sum(OrderQty) as Total_Units
from sales.SalesOrderDetail
where ProductID = 774 or ProductID = 777
group by ProductID;


/*2.1, Display the total amount collected from selling the products, from 700 - 800. */
select ProductID,
	sum(LineTotal) as Total_Amount,
	avg(UnitPrice) as Avg_Unit_Price,
	max(UnitPrice) as Max_Unit_Price,
	min(UnitPrice) as Min_Unit_Price,
	sum(OrderQty) as Total_Units
from sales.SalesOrderDetail
where ProductID between 700 and 800
group by ProductID
having sum(OrderQty) > 3000
order by sum(OrderQty) desc;

/*3, Write a query to display the sales person BusinessEntityID, last name and first name of all the sales persons and the name of the territory to which they belong.*/
select s.BusinessEntityID,
	p.LastName,
	p.FirstName,
	t.TerritoryID
from sales.SalesPerson as s
join Person.Person as p
	on p.BusinessEntityID = s.BusinessEntityID
full outer join Sales.SalesTerritory as t
	on t.TerritoryID = s.TerritoryID


/*4,  Write a query to display the Business Entities of the customers that have the 'Vista' credit card.*/
/* Tables: Sales.CreditCard, Sales.PersonCreditCard, Person.Person*/
select p.BusinessEntityID,
	p.FirstName,
	p.LastName,
	cc.CardType
from Sales.PersonCreditCard as pc
join Sales.CreditCard as cc
	on cc.CreditCardID = pc.CreditCardID
join Person.Person as p
	on p.BusinessEntityID = pc.BusinessEntityID
where cc.CardType = 'Vista'


/*Show the number of customers for each type of credit cards*/



/*5, Write a query to display ALL the country region codes along with their corresponding territory IDs*/
/* tables: Sales.SalesTerritory*/
select cr.CountryRegionCode,
	st.Name as Country_Region_Code,
	st.TerritoryID
from Sales.SalesTerritory as st
right outer join Person.CountryRegion as cr
	on cr.CountryRegionCode = st.CountryRegionCode
where st.TerritoryID is NULL; /* List all countries/regions that do not belong to a territory */


/*6, Find out the average of the total dues of all the orders.*/
select avg(TotalDue)
from Sales.SalesOrderHeader;

/*7, Write a query to report the sales order ID of those orders where the total due is greater than the average of the total dues of all the orders*/
select sh.SalesOrderID,
	sh.TotalDue
from Sales.SalesOrderHeader as sh
where TotalDue > 
	(
		select avg(TotalDue)
		from Sales.SalesOrderHeader
	)
order by TotalDue;

