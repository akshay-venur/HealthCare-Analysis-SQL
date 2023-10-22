-- Problem Statement 5:  Jhonny, from the finance department of Arizona(AZ), has requested a report that lists the total quantity of medicine
--  each pharmacy in his state has prescribed that falls under Tax criteria I for treatments that took place in 2021. Assist Jhonny in generating the report. 

select   p2.pharmacyID ,p2.pharmacyName,  sum(quantity) as total_quantity
from
treatment t 
inner join prescription p1  on p1.treatmentID = t.treatmentID
inner join  contain c on c.prescriptionID = p1.prescriptionID
inner join medicine m on m.medicineID = c.medicineID
inner join pharmacy p2 on p2.pharmacyID = p1.pharmacyID
inner join address a on a.addressID = p2.addressID
where year(date) = 2021 and m.taxCriteria ='I' and a.state = 'AZ'
group by p2.pharmacyid
