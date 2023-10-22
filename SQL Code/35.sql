-- Problem Statement 5:  
-- Anna wants a report on the pricing of the medicine. She wants a list of the most expensive and most affordable medicines only. 
-- Assist anna by creating a report of all the medicines which are pricey and affordable, listing the companyName, productName, description, maxPrice,
--  and the price category of each. Sort the list in descending order of the maxPrice.
-- Note: A medicine is considered to be “pricey” if the max price exceeds 1000 and “affordable” if the price is under 5. Write a query to find 

with cte as (select  medicineid , companyName, productName, description, maxPrice,
case 
	when maxprice > 1000 then 'pricey' 
    when maxprice <5 then 'affordable'
    end as price_category 
 from medicine)
 
select * 
from cte 
where price_category is not null
order by maxprice desc
 