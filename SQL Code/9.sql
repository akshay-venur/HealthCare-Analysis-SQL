-- Problem Statement 4: The Healthcare department wants to know which disease is most likely to infect multiple people in the same household.
-- For each disease find the number of households that has more than one patient with the same disease. 
-- Note: 2 people are considered to be in the same household if they have the same address. 


with d_count as (select t.diseaseID , p1.addressid ,count(*) as infected_people
from person p1
inner join 
address a 
on a.addressID = p1.addressid 
inner join 
patient p2
on p2.patientID = p1.personid 
inner join
treatment t
on p2.patientID = t.patientID 
group by t.diseaseID ,  p1.addressid
having count(*) >1 )

select diseaseID , count(*) as infected_household
from d_count 
group by diseaseid 
order by 1 ;



