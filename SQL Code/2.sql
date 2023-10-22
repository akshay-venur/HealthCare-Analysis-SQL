-- Problem Statement 2:  Jimmy, from the healthcare department, wants to know which disease is infecting people of which gender more often.
-- Assist Jimmy with this purpose by generating a report that shows for each disease the male-to-female ratio. Sort the data in a way that is helpful for Jimmy.
select * from patient; -- 1126
select * from treatment; -- 10885
select * from person; -- 2678


with d_group  as  (select p1.personid, p1.gender , t.treatmentID , d.diseaseID ,d.diseaseName
from person p1
inner join
patient p2
on p1.personid  = p2.patientid
inner join
treatment t
on p2.patientID = t.patientID
inner join disease d
on d.diseaseID = t.diseaseID),

gender_count as 
(select diseaseID ,diseaseName, gender , count(*) as d_count
from  d_group
group by diseaseid , gender )

select diseaseName , gender , round((d_count / sum(d_count) over( partition by diseaseID  ) )*100,2) as d_percentage
from gender_count;


