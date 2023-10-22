-- Problem Statement 3:  
-- Sarah, from the healthcare department, is trying to understand
-- if some diseases are spreading in a particular region. 
-- Assist Sarah by creating a report which shows for each state, 
-- the number of the most and least treated diseases by 
-- the patients of that state  in the year 2022. 
with cte as (select a.state , d.diseaseID , d.diseasename , count(*)  as no_of_treatment ,
dense_rank() over(partition by state order by count(*) desc) as dh_rank,
dense_rank() over(partition by state order by count(*) ) as dl_rank
FROM person p1
  INNER JOIN address a ON a.addressid = p1.addressID
  INNER JOIN patient p2 ON p1.personid = p2.patientID
  INNER JOIN treatment t ON p2.patientID = t.patientID
  INNER JOIN  disease d on d.diseaseID  = t.diseaseID
where year(t.date) =2022
group by a.state , d.diseaseID
order by state , 4 desc)
  
SELECT state,
  GROUP_CONCAT(CASE WHEN dh_rank = 1 THEN diseasename END) AS most_treated_disease,
  GROUP_CONCAT(CASE WHEN dl_rank = 1 THEN diseasename END) AS least_treated_disease
FROM cte
group by state