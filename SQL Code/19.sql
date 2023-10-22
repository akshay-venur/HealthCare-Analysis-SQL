-- Problem Statement 4: 
-- Mack, From HealthDirect Pharmacy, wants to get a list of all the affordable and costly, hospital-exclusive medicines in the database.
--  Where affordable medicines are the medicines that have a maximum price of less than 50% of the avg maximum price of all the medicines in the database,
--  and costly medicines are the medicines that have a maximum price of more than double the avg maximum price of all the medicines in the database.
--  Mack wants clear text next to each medicine name to be displayed that identifies the medicine as affordable or costly. The medicines that do not
--  fall under either of the two categories need not be displayed.
-- Write a SQL query for Mack for this requirement.

with price as (SELECT medicineID, productName,
  CASE
    WHEN maxprice < (SELECT AVG(maxprice) FROM medicine) * 0.5 THEN 'affordable'
    WHEN maxprice > (SELECT AVG(maxprice) FROM medicine) * 2 THEN 'costly'
  END AS price_category
FROM
  medicine
WHERE
  hospitalExclusive = 'S' )
  
select * from price where  price_category is not null;



