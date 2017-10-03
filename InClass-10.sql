use AdventureWorksDW2012;

/* 1. Employees whose birthday is in February */
select *
from DimEmployee
where month(BirthDate) = 2;

/* 2. Among these employees, who are the sales representatives? */
select *
from DimEmployee
where month(BirthDate) = 2
and Title = 'Sales Representative';

/* 3. List all the sales processed by these two sales representatives */
select *
from FactResellerSales as RS
join DimEmployee as E
	on E.EmployeeKey = RS.EmployeeKey
where month(E.BirthDate) = 2
and E.Title = 'Sales Representative';

/* 4. Who is a better salesperson that was born in February? */
select E.EmployeeKey,
	E.FirstName,
	E.LastName,
	sum(RS.SalesAmount) as Total_Sales,
	count(RS.SalesOrderLineNumber) as Total_Orders
from FactResellerSales as RS
join DimEmployee as E
	on E.EmployeeKey = RS.EmployeeKey
where month(E.BirthDate) = 2
and E.Title = 'Sales Representative'
group by E.EmployeeKey, E.FirstName, E.LastName;

/* Find a better way to compare these two salespersons */


/* Total amount of reseller sales in Massachusettes */

/* Total amount of online sales in first quarter in each country in each year */
