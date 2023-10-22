
-- Problem Statement 1: 
-- The healthcare department wants a pharmacy report on the percentage of hospital-exclusive medicine prescribed in the year 2022.
-- Assist the healthcare department to view for each pharmacy, the pharmacy id, pharmacy name, total quantity of medicine prescribed in 2022, 
-- total quantity of hospital-exclusive medicine prescribed by the pharmacy in 2022, and the percentage of hospital-exclusive medicine to the total
--  medicine prescribed in 2022.
-- Order the result in descending order of the percentage found. 

WITH all_medicine AS (
    SELECT p2.pharmacyID, p2.pharmacyName, c.quantity, p1.prescriptionID, m.medicineID, hospitalExclusive
    FROM
        treatment t
    INNER JOIN prescription p1 ON p1.treatmentID = t.treatmentID
    INNER JOIN contain c ON c.prescriptionID = p1.prescriptionID
    INNER JOIN medicine m ON m.medicineID = c.medicineID
    INNER JOIN pharmacy p2 ON p2.pharmacyID = p1.pharmacyID
    WHERE YEAR(t.date) = 2022
),
pharmacy_summary AS (
    SELECT pharmacyID, pharmacyName, COUNT(*) AS total_medicine,
        SUM(CASE WHEN hospitalExclusive = 'S' THEN 1 ELSE 0 END) AS total_ex_medicine
    FROM all_medicine
    GROUP BY pharmacyID, pharmacyName
)

SELECT
    pharmacyID, pharmacyName, total_medicine, total_ex_medicine, ROUND((total_ex_medicine / total_medicine) * 100, 2) AS percentage
FROM pharmacy_summary
ORDER BY percentage DESC;
