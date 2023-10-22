-- Problem Statement 6: A company needs to set up 3 new pharmacies, they have come up with an idea that the pharmacy can be set up in cities
--  where the pharmacy-to-prescription ratio is the lowest and the number of prescriptions should exceed 100. Assist the company to identify those 
--  cities where the pharmacy can be set up.

-- select * from pharmacy; -- pharmacyID, pharmacyName, addressID
-- SELECT * from address; -- addressid , city 
-- select * from prescription; -- prescriptionID, pharmacyID

select city , count(distinct p1.pharmacyID) / (count(p2.prescriptionID)) as ratio
from pharmacy p1
inner join address a on a.addressID = p1.addressID
inner join prescription p2 on p2.pharmacyID = p1.pharmacyID
group by city
having  count(p2.prescriptionID) >100
order by 2 
limit 3






