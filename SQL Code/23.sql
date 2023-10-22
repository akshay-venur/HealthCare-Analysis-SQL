-- Problem Statement 3:  
-- Kelly, from the Fortis Hospital management, has requested a report 
-- that shows for each disease, the top 3 cities that had the most number treatment
--  for that disease.
-- Generate a report for Kelly’s requirement.

with city_r as (select t.diseaseID , d.diseaseName, a.city , count(*) as treatment_count,
dense_rank() OVER (PARTITION BY t.diseaseID ORDER BY COUNT(*) DESC) AS cityRank
from  person p1
inner join address a on a.addressid = p1.addressid
inner join patient p2 on p2.patientID = p1.personID
inner join  treatment t on t.patientID = p2.patientID
inner join disease d on t.diseaseID = d.diseaseID
group by t.diseaseID , a.city )

SELECT
  diseaseName, GROUP_CONCAT(city ORDER BY treatment_count DESC SEPARATOR ', ') AS top3Cities
FROM city_r
WHERE cityRank <= 3
GROUP BY diseaseID, diseaseName;


