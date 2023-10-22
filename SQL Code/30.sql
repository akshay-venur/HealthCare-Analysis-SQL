-- Problem Statement 5:  
-- It is suspected by healthcare research department that the substance “ranitidina” might be causing some side effects.
--  Find the top 3 companies using the substance in their medicine so that they can be informed about it.

select medicineid 
from medicine
where substanceName like "%ranitidina" ;


select p.pharmacyID, p.pharmacyName, count(*) 
from pharmacy  p
inner join
keep k 
on p.pharmacyID = k.pharmacyID
where medicineID in (
					select medicineid 
					from medicine
					where substanceName like "%ranitidina" )
group by pharmacyID 
order by 3 desc limit 3
				