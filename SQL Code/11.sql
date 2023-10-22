-- Problem Statement 1:  Some complaints have been lodged by patients that they have been prescribed hospital-exclusive medicine that they can’t find
--  elsewhere and facing problems due to that. Joshua, from the pharmacy management, wants to get a report of which pharmacies have prescribed
--  hospital-exclusive medicines the most in the years 2021 and 2022. Assist Joshua to generate the report so that the pharmacies who prescribe
--  hospital-exclusive medicine more often are advised to avoid such practice if possible.   


SELECT p1.pharmacyID , p2.pharmacyname , count(*) as count_of_exclusive_medicine
from treatment t
inner join  prescription p1 on t.treatmentID  = p1.treatmentID
inner join contain c on p1.prescriptionID = c.prescriptionID
inner join  medicine m
on m.medicineID = c.medicineID inner join
pharmacy p2  on p2.pharmacyID = p1.pharmacyID
where date between '2021-01-01' and '2022-12-31' and m.hospitalExclusive = 'S'
group by pharmacyID
order by 3 desc

