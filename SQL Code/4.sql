-- Problem Statement 4: The Healthcare department wants a report about the inventory of pharmacies.
-- Generate a report on their behalf that shows how many units of medicine each pharmacy has in their inventory,
-- the total maximum retail price of those medicines, and the total price of all the medicines after discount. 
-- Note: discount field in keep signifies the percentage of discount on the maximum price.

-- select * from pharmacy;
-- select * from medicine;
-- select * from keep; -- 55357

-- select pharmacyId , count(medicineId)
-- from keep
-- group by pharmacyId;

with cal_discount as (select k.pharmacyID, p.pharmacyName, k.medicineID, k.quantity, k.discount , m.maxprice , round((m.maxprice - m.maxprice*(k.discount/100)),2) as price_after_discount
from keep k
inner join
medicine m 
on m.medicineID = k.medicineID
inner join pharmacy p
on p.pharmacyID = k.pharmacyID)

select pharmacyID , pharmacyName , sum(quantity) as total_units_medicine , sum(maxprice*quantity) as maximum_retal_price , sum(price_after_discount*quantity) as total_price_discount
from cal_discount
group by pharmacyID
