-- Problem Statement 1: 
-- Brian, the healthcare department, has requested for a report that shows for each state how many people underwent treatment for the disease “Autism”.
--   He expects the report to show the data for each state as well as each gender and for each state and gender combination. 
-- Prepare a report for Brian for his requirement.

SELECT
    state,
    gender,
    COUNT(*) AS num_patients
FROM address a
INNER JOIN person p1 ON p1.addressid = a.addressid
INNER JOIN patient p2 ON p1.personid = p2.patientid
INNER JOIN treatment t ON t.patientID = p2.patientID
INNER JOIN disease d ON d.diseaseID = t.diseaseID
WHERE d.diseaseName ='Autism'
GROUP BY state, gender WITH ROLLUP;
-- GROUP BY gender , state WITH ROLLUP;




