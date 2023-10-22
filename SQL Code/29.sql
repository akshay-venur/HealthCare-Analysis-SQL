-- Problem Statement 4: 
-- Manish, from the healthcare department, wants to know how many registered people are registered as patients as well, in each city.
--  Generate a report that shows each city that has 10 or more registered people belonging to it and the number of patients from that city
--  as well as the percentage of the patient with respect to the registered people.

SELECT 
  a.city,
  COUNT(*) AS registered_people,
  SUM(CASE WHEN p2.patientID IS NOT NULL THEN 1 ELSE 0 END) AS patients,
  ROUND(SUM(CASE WHEN p2.patientID IS NOT NULL THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS percentage
FROM 
  address a
INNER JOIN 
  person p1 ON a.addressid = p1.addressid
LEFT JOIN 
  patient p2 ON p1.personid = p2.patientID
GROUP BY 
  a.city
HAVING 
  COUNT(*) >= 10
ORDER BY 
  a.city;
