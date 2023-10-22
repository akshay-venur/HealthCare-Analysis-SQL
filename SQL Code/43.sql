-- Problem Statement 3:  
-- Sarah, from the healthcare department, is trying to understand if some diseases are spreading in a particular region. 
-- Assist Sarah by creating a report which shows each state the number of the most and least treated diseases by the patients of 
-- that state in the year 2022. It would be helpful for Sarah if the aggregation for the different combinations is found as well. 
-- Assist Sarah to create this report. 

select a.state  , d.diseaseName , count(*) as num_patients
from address a 
inner join person p1 on p1.addressID = a.addressID
inner join patient p2 on p1.personID = p2.patientID
inner join treatment t on t.patientID = p2.patientID
inner join disease d on d.diseaseID = t.diseaseID 
where year(date) =2022 
group by state ,  d.diseaseName WITH ROLLUP 
order by 1 , 3 desc;








