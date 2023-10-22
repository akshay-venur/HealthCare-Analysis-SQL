-- Problem Statement 4: 
-- Brooke is trying to figure out if patients with a particular disease are preferring some pharmacies over others or not, 
-- For this purpose, she has requested a detailed pharmacy report that shows each pharmacy name, and how many prescriptions 
-- they have prescribed for each disease in 2021 and 2022, She expects the number of prescriptions prescribed in 2021 and 2022 be displayed
-- in two separate columns.
-- Write a query for Brooke’s requirement.



WITH cte1 AS (
    SELECT p2.pharmacyID, p2.pharmacyName, d.diseaseID, d.diseaseName, p1.prescriptionID, t.date
    FROM
        treatment t
    INNER JOIN disease d ON d.diseaseID = t.diseaseID
    INNER JOIN prescription p1 ON p1.treatmentID = t.treatmentID
    INNER JOIN pharmacy p2 ON p1.pharmacyID = p2.pharmacyID
),
year_2021 AS (
    SELECT pharmacyID, diseaseID, COUNT(*) AS `count_2021`
    FROM cte1
    WHERE YEAR(date) = 2021
    GROUP BY diseaseID, pharmacyID
),
year_2022 AS (
    SELECT pharmacyID, diseaseID, COUNT(*) AS `count_2022`
    FROM cte1
    WHERE YEAR(date) = 2022
    GROUP BY diseaseID, pharmacyID
)
SELECT
    COALESCE(y1.pharmacyID, y2.pharmacyID) AS pharmacyID,
    COALESCE(y1.diseaseID, y2.diseaseID) AS diseaseID,
    COALESCE(`count_2021`, 0) AS `count_2021`,
    COALESCE(`count_2022`, 0) AS `count_2022`
FROM year_2021 y1
LEFT JOIN year_2022 y2 ON y1.pharmacyID = y2.pharmacyID AND y1.diseaseID = y2.diseaseID
UNION
SELECT
    COALESCE(y1.pharmacyID, y2.pharmacyID) AS pharmacyID,
    COALESCE(y1.diseaseID, y2.diseaseID) AS diseaseID,
    COALESCE(`count_2021`, 0) AS `count_2021`,
    COALESCE(`count_2022`, 0) AS `count_2022`
FROM year_2021 y1
RIGHT JOIN year_2022 y2 ON y1.pharmacyID = y2.pharmacyID AND y1.diseaseID = y2.diseaseID
order by pharmacyid , diseaseid;






