-- Problem Statement 5:  
-- The healthcare department wants to categorize the patients into the following category.
-- YoungMale: Born on or after 1st Jan  2005  and gender male.
-- YoungFemale: Born on or after 1st Jan  2005  and gender female.
-- AdultMale: Born before 1st Jan 2005 but on or after 1st Jan 1985 and gender male.
-- AdultFemale: Born before 1st Jan 2005 but on or after 1st Jan 1985 and gender female.
-- MidAgeMale: Born before 1st Jan 1985 but on or after 1st Jan 1970 and gender male.
-- MidAgeFemale: Born before 1st Jan 1985 but on or after 1st Jan 1970 and gender female.
-- ElderMale: Born before 1st Jan 1970, and gender male.
-- ElderFemale: Born before 1st Jan 1970, and gender female.

-- Write a SQL query to list all the patient name, gender, dob, and their category.
select p1.personName AS patient_name , p1.gender , p2.dob,
case 
	when dob >='2005-01-01' and gender ='male' then 'YoungMale'
    when dob >='2005-01-01' and gender ='female' then 'YoungFemale'
    when dob >='1985-01-01' and dob <'2005-01-01' and gender='male' then 'AdultMale'
    when dob >='1985-01-01' and dob <'2005-01-01' and gender='female' then 'AdultMale'
    when dob>='1970-01-01' and dob <'1985-01-01' and gender ='male' then 'MidAgeMale'
    when dob>='1970-01-01' and dob <'1985-01-01' and gender ='female' then 'MidAgeFemale'
    when dob <'1970-01-01' and gender ='male' then 'ElderMale'
    when dob <'1970-01-01' and gender ='female' then 'ElderFemale'
    end as gender_category
    
from person p1
inner join
patient p2
on p1.personid = p2.patientid;