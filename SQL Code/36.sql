-- -- For each age(in years), how many patients have gone for treatment?
-- SELECT DATEDIFF(hour, dob , GETDATE())/8766 AS age, count(*) AS numTreatments
-- FROM Person
-- JOIN Patient ON Patient.patientID = Person.personID
-- JOIN Treatment ON Treatment.patientID = Patient.patientID
-- group by DATEDIFF(hour, dob , GETDATE())/8766
-- order by numTreatments desc;

-- changed the function which calculate the age 
-- Avoiding Function in GROUP BY: Using a function in the GROUP BY clause might impact performance. To optimize, you can calculate the age in a subquery
--  or a Common Table Expression (CTE) and then group by the age column directly. This way, the timestampdiff() function is only computed once for each row.

with cte as (SELECT timestampdiff(year, dob , curdate()) AS age
FROM Person
JOIN Patient ON Patient.patientID = Person.personID
JOIN Treatment ON Treatment.patientID = Patient.patientID)

select * , count(*) as numTreatments
from cte 
group by age 
order by numTreatments desc

