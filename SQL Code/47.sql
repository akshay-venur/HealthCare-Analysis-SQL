-- It was reported by some unverified sources that some pharmacies are more popular for certain diseases. The healthcare department wants to check 
-- the validity of this report.
-- Create a stored procedure that takes a disease name as a parameter and would return the top 3 pharmacies the patients are preferring for the
--  treatment of that disease in 2021 as well as for 2022.
-- Check if there are common pharmacies in the top 3 list for a disease, in the years 2021 and the year 2022.
-- Call the stored procedure by passing the values “Asthma” and “Psoriasis” as disease names and draw a conclusion from the result.
DROP PROCEDURE IF EXISTS disease_pharmacy_detail_proc;
DELIMITER //

CREATE PROCEDURE disease_pharmacy_detail_proc(IN input_diseaseName VARCHAR(50))
BEGIN
with 2021_disease_data as (
select diseaseName,pharmacyName,count(pr.prescriptionID) count_of_pharma,DENSE_RANK() over(order by count(pr.prescriptionID) desc) as rnk
from disease d 
join treatment t using(diseaseID)
join prescription pr using(treatmentID)
join pharmacy p using(pharmacyID)
where year(t.date)=2021 
and diseaseName = input_diseaseName
group by diseaseName,pharmacyName
order by rnk 
)
select diseaseName,pharmacyName,count_of_pharma from 2021_disease_data where rnk<=3;

with 2022_disease_data as (
select diseaseName,pharmacyName,count(pr.prescriptionID) count_of_pharma,DENSE_RANK() over(order by count(pr.prescriptionID) desc) as rnk
from disease d 
join treatment t using(diseaseID)
join prescription pr using(treatmentID)
join pharmacy p using(pharmacyID)
where year(t.date)=2022 
and diseaseName = input_diseaseName
group by diseaseName,pharmacyName
order by rnk 
)
select diseaseName,pharmacyName,count_of_pharma from 2022_disease_data where rnk<=3;

END //

DELIMITER ;

CALL disease_pharmacy_detail_proc('Asthma');
