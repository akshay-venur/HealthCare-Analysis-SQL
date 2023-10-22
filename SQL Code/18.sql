-- Problem Statement 3: 
-- In the Inventory of a pharmacy 'Spot Rx' the quantity of medicine is considered ‘HIGH QUANTITY’ when the quantity exceeds 7500 and ‘LOW QUANTITY’
--  when the quantity falls short of 1000. The discount is considered “HIGH” if the discount rate on a product is 30% or higher,
--  and the discount is considered “NONE” when the discount rate on a product is 0%.
--  'Spot Rx' needs to find all the Low quantity products with high discounts and all the high-quantity products with no discount so they can 
--  adjust the discount rate according to the demand. 
-- Write a query for the pharmacy listing all the necessary details relevant to the given requirement.

-- Hint: Inventory is reflected in the Keep table.

with cte as (select p.pharmacyID  , p.pharmacyName , k.medicineID , k.quantity , k.discount ,
case 
	when quantity > 7500 then 'High Quantity'
    when quantity <1000 then 'Low Quantity'
    end as quantity_tag ,
case 
	when discount >=30 then 'High'
    when discount =0 then 'None'
    end as discount_tag
from pharmacy p
inner join 
keep k
on p.pharmacyID = k.pharmacyID
where p.pharmacyName='Spot Rx') 

select * 
from cte
where (quantity_tag = 'Low Quantity' and discount_tag='High' ) or (quantity_tag = 'High Quantity' and discount_tag='None') ;

