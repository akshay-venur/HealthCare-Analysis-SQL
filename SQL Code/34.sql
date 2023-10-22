-- Problem Statement 4: 
-- The healthcare department wants to know which category of patients is being affected the most by each disease.
-- Assist the department in creating a report regarding this.
-- Provided the healthcare department has categorized the patients into the following category.
-- YoungMale: Born on or after 1st Jan  2005  and gender male.
-- YoungFemale: Born on or after 1st Jan  2005  and gender female.
-- AdultMale: Born before 1st Jan 2005 but on or after 1st Jan 1985 and gender male.
-- AdultFemale: Born before 1st Jan 2005 but on or after 1st Jan 1985 and gender female.
-- MidAgeMale: Born before 1st Jan 1985 but on or after 1st Jan 1970 and gender male.
-- MidAgeFemale: Born before 1st Jan 1985 but on or after 1st Jan 1970 and gender female.
-- ElderMale: Born before 1st Jan 1970, and gender male.
-- ElderFemale: Born before 1st Jan 1970, and gender female.


select diseaseID , diseaseName , gender_category , total_count from  (select   d.diseaseID , d.diseaseName, 
case 
	when dob >='2005-01-01' and gender ='male' then 'YoungMale'
    when dob >='2005-01-01' and gender ='female' then 'YoungFemale'
    when dob >='1985-01-01' and dob <'2005-01-01' and gender='male' then 'AdultMale'
    when dob >='1985-01-01' and dob <'2005-01-01' and gender='female' then 'AdultMale'
    when dob>='1970-01-01' and dob <'1985-01-01' and gender ='male' then 'MidAgeMale'
    when dob>='1970-01-01' and dob <'1985-01-01' and gender ='female' then 'MidAgeFemale'
    when dob <'1970-01-01' and gender ='male' then 'ElderMale'
    when dob <'1970-01-01' and gender ='female' then 'ElderFemale'
    end as gender_category,
    count(*) as total_count , 
    rank() over( partition by d.diseaseID order by count(*) desc) as d_rank
    
from person p1
inner join patient p2 on p1.personid = p2.patientid
inner join treatment t on t.patientID = p2.patientID
inner join disease d on d.diseaseID = t.diseaseID
group by d.diseaseID , gender_category
order by d.diseaseID , count(*) desc) t
where d_rank =1
