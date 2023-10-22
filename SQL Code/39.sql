-- Query 4: 
-- The total quantity of medicine in a prescription is the sum of the quantity of all the medicines in the prescription.
-- Select the prescriptions for which the total quantity of medicine exceeds
-- the avg of the total quantity of medicines for all the prescriptions.

-- drop table if exists T1;


-- select Pharmacy.pharmacyID, Prescription.prescriptionID, sum(quantity) as totalQuantity
-- into T1
-- from Pharmacy
-- join Prescription on Pharmacy.pharmacyID = Prescription.pharmacyID
-- join Contain on Contain.prescriptionID = Prescription.prescriptionID
-- join Medicine on Medicine.medicineID = Contain.medicineID
-- join Treatment on Treatment.treatmentID = Prescription.treatmentID
-- where YEAR(date) = 2022
-- group by Pharmacy.pharmacyID, Prescription.prescriptionID
-- order by Pharmacy.pharmacyID, Prescription.prescriptionID;


-- select * from T1
-- where totalQuantity > (select avg(totalQuantity) from T1);

-- To optimize the provided query, you can calculate the average of the total quantity of medicines for all prescriptions using a Common Table Expression 
-- (CTE) and then directly compare the total quantity in each prescription with this average. The query is more organized and easier to read because it uses CTEs to break down the logic into smaller, named parts.
-- CTEs help avoid redundancy by defining the intermediate result sets only once and referencing them multiple times in the main query.

WITH PrescriptionTotalQuantity AS (
  SELECT Pharmacy.pharmacyID, Prescription.prescriptionID, SUM(quantity) AS totalQuantity
  FROM Pharmacy
  JOIN Prescription ON Pharmacy.pharmacyID = Prescription.pharmacyID
  JOIN Contain ON Contain.prescriptionID = Prescription.prescriptionID
  JOIN Medicine ON Medicine.medicineID = Contain.medicineID
  JOIN Treatment ON Treatment.treatmentID = Prescription.treatmentID
  WHERE YEAR(date) = 2022
  GROUP BY Pharmacy.pharmacyID, Prescription.prescriptionID
)
, AverageTotalQuantity AS (
  SELECT AVG(totalQuantity) AS avgTotalQuantity
  FROM PrescriptionTotalQuantity
)
SELECT
  T1.pharmacyID, T1.prescriptionID, T1.totalQuantity
FROM PrescriptionTotalQuantity T1
JOIN
  AverageTotalQuantity T2 ON T1.totalQuantity > T2.avgTotalQuantity;
