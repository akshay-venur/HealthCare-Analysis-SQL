-- Problem Statement 7: The State of Alabama (AL) is trying to manage its healthcare resources more efficiently. For each city in their state,
-- they need to identify the disease for which the maximum number of patients have gone for treatment.
-- Assist the state for this purpose.
-- Note: The state of Alabama is represented as AL in Address Table


select city , diseasename , disease_count from (select   a.city  ,d.diseaseID ,d.diseasename ,  count(*) as disease_count , rank() over (partition by a.city order by count(*) desc) as d_rank
from person p1 
inner join
address a 
on p1.addressid = a.addressid 
inner join 
patient p2
on p2.patientid = p1.personid
inner join 
treatment t
on t.patientID = p2.patientID
inner join
disease d
on d.diseaseID =  t.diseaseID 
where a.state = 'AL' 
group by a.city , d.diseaseID 
order by 4 desc) t
where d_rank =1;




