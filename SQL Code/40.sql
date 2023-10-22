-- Query 5: 

-- Select every disease that has 'p' in its name, and 
-- the number of times an insurance claim was made for each of them. 

SELECT Disease.diseaseName, COUNT(*) as numClaims
FROM Disease
JOIN Treatment ON Disease.diseaseID = Treatment.diseaseID
JOIN Claim On Treatment.claimID = Claim.claimID
WHERE diseaseName IN (SELECT diseaseName from Disease where diseaseName LIKE '%p%')
GROUP BY diseaseName;

-- to optimize the provided query, you can eliminate the subquery and directly use the LIKE operator to filter diseases with 'p' in their name. 

SELECT Disease.diseaseName, COUNT(*) AS numClaims
FROM Disease
JOIN Treatment ON Disease.diseaseID = Treatment.diseaseID
JOIN Claim ON Treatment.claimID = Claim.claimID
WHERE Disease.diseaseName LIKE '%p%'
GROUP BY Disease.diseaseName;
