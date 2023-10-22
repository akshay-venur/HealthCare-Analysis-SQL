-- Problem Statement 2:  
-- Sarah, from the healthcare department, has noticed many people do not claim insurance for their treatment. She has requested a state-wise report 
-- of the percentage of treatments that took place without claiming insurance. Assist Sarah by creating a report as per her requirement.

SELECT
  a.state,
  ROUND((COUNT(CASE WHEN t.claimID IS NULL THEN 1 END) / COUNT(*)) * 100, 2) AS percentage
FROM
  person p1
  INNER JOIN address a ON a.addressid = p1.addressID
  INNER JOIN patient p2 ON p1.personid = p2.patientID
  INNER JOIN treatment t ON p2.patientID = t.patientID
GROUP BY a.state;








