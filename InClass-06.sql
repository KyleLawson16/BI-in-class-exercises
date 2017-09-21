use AdventureWorks2012;

/* Number of employees in each department */
select JobTitle
	,count(BusinessEntityID) as Employees
from HumanResources.Employee
where CurrentFlag = 1
group by JobTitle

/* departments having more than one employee */
select JobTitle
	,count(BusinessEntityID) as Employees
from HumanResources.Employee
where CurrentFlag = 1
group by JobTitle
having count(BusinessEntityID) > 1
order by count(BusinessEntityID) desc;

/* example in PPT -- in each territory, and each day before 2007, what were the orders */
select TerritoryID,
	OrderDate,
	count(SalesOrderID) as Number_of_Orders,
	sum(TotalDue) as Amount_Due
from sales.SalesOrderHeader
where OrderDate < '2007-01-01'
group by TerritoryID,
	OrderDate
having sum(TotalDue) > 5000;

/* Activity 3 */
select i.ProductID,
	p.Name,
	l.Name as Location
from Production.ProductInventory as i
	join Production.Product as p on p.ProductID = i.ProductID
	join Production.Location as l on l.LocationID = i.LocationID

/* Activity 4 */
select p.ProductModelID,
	p.Name
from Production.Product as p
	right outer join Production.ProductModel as m on m.ProductModelID = p.ProductModelID
where p.ProductModelID is null


