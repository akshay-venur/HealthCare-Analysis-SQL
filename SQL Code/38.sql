-- Total quantity of medicine for each prescription prescribed by Ally Scripts
-- If the total quantity of medicine is less than 20 tag it as "Low Quantity".
-- If the total quantity of medicine is from 20 to 49 (both numbers including) tag it as "Medium Quantity".
-- If the quantity is more than equal to 50 then tag it as "High quantity".

-- select 
-- C.prescriptionID, sum(quantity) as totalQuantity,
-- CASE WHEN sum(quantity) < 20 THEN 'Low Quantity'
-- WHEN sum(quantity) < 50 THEN 'Medium Quantity'
-- ELSE 'High Quantity' END AS Tag
-- FROM Contain C
-- JOIN Prescription P 
-- on P.prescriptionID = C.prescriptionID
-- JOIN Pharmacy on Pharmacy.pharmacyID = P.pharmacyID
-- where Pharmacy.pharmacyName = 'Ally Scripts'
-- group by C.prescriptionID;

-- query can be further optimized by using a Common Table Expression (CTE) to calculate the total quantity of medicine for each prescription and then 
-- applying the CASE statement on the computed total quantity. This way, the total quantity calculation is done only once for each prescription, 
-- reducing redundant calculations.

WITH PrescriptionQuantity AS (
  SELECT 
    C.prescriptionID, 
    SUM(quantity) AS totalQuantity
  FROM Contain C
  JOIN Prescription P ON P.prescriptionID = C.prescriptionID
  JOIN Pharmacy ON Pharmacy.pharmacyID = P.pharmacyID
  WHERE Pharmacy.pharmacyName = 'Ally Scripts'
  GROUP BY C.prescriptionID
)
SELECT
  prescriptionID,
  totalQuantity,
  CASE
    WHEN totalQuantity < 20 THEN 'Low Quantity'
    WHEN totalQuantity < 50 THEN 'Medium Quantity'
    ELSE 'High Quantity'
  END AS Tag
FROM PrescriptionQuantity;

