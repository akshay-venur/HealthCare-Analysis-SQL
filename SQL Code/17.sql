-- Problem Statement 2:  
-- 'Ally Scripts' pharmacy company wants to find out the quantity of medicine prescribed in each of its prescriptions.
-- Write a query that finds the sum of the quantity of all the medicines in a prescription and if the total quantity of medicine is less than 20 tag it
--  as “low quantity”. If the quantity of medicine is from 20 to 49 (both numbers including) tag it as “medium quantity“ and if the quantity is more than 
--  equal to 50 then tag it as “high quantity”.
-- Show the prescription Id, the Total Quantity of all the medicines in that prescription, and the Quantity tag for all the prescriptions issued by
--  'Ally Scripts'.
-- 3 rows from the resultant table may be as follows:
-- prescriptionID	totalQuantity	Tag
-- 1147561399		43			Medium Quantity
-- 1222719376		71			High Quantity
-- 1408276190		48			Medium Quantity

with quantity as (select p.prescriptionID , sum(quantity) as total_quantity 
from prescription p
inner join
contain c
on c.prescriptionID  = p.prescriptionID
inner join 
pharmacy p1
on p1.pharmacyID = p.pharmacyID
where p1.pharmacyName = 'Ally Scripts'
group by prescriptionID)

select * ,
case
	when total_quantity <20 then 'low quantity'
    when total_quantity between 10 and 49 then 'medium quantity'
    else 'high quantity'
    end as quantity_tag
from quantity;




