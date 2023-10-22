-- Johansson is trying to prepare a report on patients who have gone through treatments more than once.
--  Help Johansson prepare a report that shows the patient's name, the number of treatments they have undergone, and their age,
--  Sort the data in a way that the patients who have undergone more treatments appear on top.

select p2.personname ,timestampdiff(year,dob, curdate()) as age ,count(*) as no_of_treatment
from patient p1
inner join 
person p2
on p1.patientID = p2.personid
inner join 
treatment  t
on t.patientid =  p1.patientID
group by (p1.patientid)
order by 3 desc