-- Jack Jiang (z5129432)

-- Question 1
create or replace view Q1(Name, Country) as
select name, country
from company
where country != 'Australia'
order by name;

-- Qustion 2
create or replace view Q2(Codes) AS
select code, count(person)
from Executive
group by code
having count(person) > 5
order by code;

-- Question 3
create or replace view Q3(Name) AS
select CO.Name
from Company CO, Category CA
where CO.Code=CA.Code and CA.Sector='Technology'
order by name;

-- Question 4
create or replace view Q4(Sector, "Number") AS
select Sector, count(distinct Industry) as "Number"
from Category
group by sector
order by Sector;

-- Question 5
create or replace view Q5(Name) AS
select E.Person
from Executive E, Category C
where E.Code=C.Code and C.Sector='Technology'
order by E.person;

-- Question 6
create or replace view Q6(Name) AS
select CO.Name
from Company CO, Category CA
where CO.Code=CA.Code and CA.Sector='Services' and CO.zip like '2%'
order by CO.Name;

-- Question 7 ???????????????????????????????????????????????????
create or replace view PrePrice("Date", Code, PrePrice) AS
select ("Date")+1, Code, Price
FROM ASX;

create or replace view Q7("Date", Code, Volume, PrevPrice, Price, Change, Gain) AS
select A."Date", A.Code, A.Volume, P.PrePrice, A.Price, A.Price-P.PrePrice, (A.Price-P.PrePrice) / P.PrePrice * 100
from ASX A, Preprice P
where A."Date"=P."Date" and A.Code=P.Code
order by "Date";

-- Question 8
create or replace view MaxVol("Date", MaxVolume) as
select "Date", max(volume)
from ASX
group by "Date";

create or replace view Q8("Date", Code, Volume) AS
select ASX."Date", ASX.Code, ASX.Volume
from ASX, MaxVol
WHERE ASX."Date"=MaxVol."Date" and ASX.Volume=MaxVol.MaxVolume
order by "Date", Code;

-- Question 9
create or replace view Q9(Sector, Industry, "Number") AS
select Sector, Industry, count(*)
from Category
group by Industry, Sector
order by Sector, Industry;

-- Qustion 10
create or replace view Q10(Code, Industry) AS
select Code, Industry
from Category
group by Industry
having count(*) = 1;