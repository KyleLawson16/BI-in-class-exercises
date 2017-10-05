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

/* Total amount of reseller sales in Massachusettes */
select G.StateProvinceName,
	sum(RS.SalesAmount) as Total_Reseller_Sales
from FactResellerSales as RS
join DimGeography as G
	on G.SalesTerritoryKey = RS.SalesTerritoryKey
where G.StateProvinceName = 'Massachusetts'
group by G.StateProvinceName;

/* Total amount of online sales in first quarter in each country in each year */
select T.SalesTerritoryCountry,
	D.FiscalYear,
	sum(S.SalesAmount) as Total_Online_Sales
from FactInternetSales as S
join DimSalesTerritory as T
	on T.SalesTerritoryKey = S.SalesTerritoryKey
join DimDate as D
	on D.DateKey = S.OrderDateKey
where D.FiscalQuarter = 1
group by T.SalesTerritoryCountry, D.FiscalYear