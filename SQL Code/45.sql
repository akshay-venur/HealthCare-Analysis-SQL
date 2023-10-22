-- Problem Statement 5:  
-- Praveen has requested for a report that finds for every disease how many males and females underwent treatment for each in the year 2022.
--  It would be helpful for Praveen if the aggregation for the different combinations is found as well.
-- Assist Praveen to create this report. 

select  d.diseaseName , p1.gender  ,count(*) 
from person p1
inner join patient p2 on p1.personID = p2.patientID
inner join treatment t on t.patientID = p2.patientID
inner join disease d on d.diseaseID = t.diseaseID
where year(t.date) = 2022
group by  d.diseaseName , p1.gender with rollup;


