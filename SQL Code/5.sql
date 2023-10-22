-- Problem Statement 5:  The healthcare department suspects that some pharmacies prescribe more medicines than others in a single prescription,
-- for them, generate a report that finds for each pharmacy the maximum, minimum and average number of medicines prescribed in their prescriptions. 


-- select p.pharmacyID  , avg(quantity) as avg , max(quantity) as max , min(quantity) as min
-- from contain c
-- inner join 
-- prescription p
-- on c.prescriptionID = p.prescriptionID
-- group by p.pharmacyID;


select pharmacyid , avg(total_quantity) as avg , max(total_quantity) as max , min(total_quantity) as min from 
(select c.prescriptionID , p.pharmacyID , sum(quantity)  as total_quantity
from contain c
inner join 
prescription p
on c.prescriptionID = p.prescriptionID
group by c.prescriptionID , p.pharmacyID) t
group by pharmacyID
