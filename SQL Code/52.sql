-- Problem Statement 2:
-- The pharmacies are trying to estimate the average cost of all the prescribed medicines per prescription, for all the prescriptions they have prescribed
--  in a particular year. Create a stored function that will return the required value when the pharmacyID and year are passed to it.
--  Test the function with multiple values.

-- delimiter $$
-- create procedure pharma_avg(in pharma_id int , in year int )
-- begin
-- 	select  pharmacyID , round(avg(total_cost),2) as avg_price from (select p1.prescriptionID , p2.pharmacyID , sum(quantity * maxprice) as total_cost
-- 	from prescription p1
-- 	inner join pharmacy p2 on p1.pharmacyID = p2.pharmacyID
-- 	inner join contain c on c.prescriptionID = p1.prescriptionID
-- 	inner join treatment t on t.treatmentID = p1.treatmentID
-- 	inner join medicine m on m.medicineID = c.medicineID 
-- 	where year(date) = year and p2.pharmacyID = pharma_id
-- 	group by p2.pharmacyID , p1.prescriptionID) t
-- 	group by pharmacyID ;
-- end $$
-- delimiter ;

-- call pharma_avg(6018,2022);

DELIMITER $$
CREATE FUNCTION pharma_avg(pharma_id INT, year INT) RETURNS DECIMAL(10, 2)
deterministic
BEGIN
    DECLARE avg_price DECIMAL(10, 2);
    
    SELECT ROUND(AVG(total_cost), 2) INTO avg_price
    FROM (
        SELECT p2.pharmacyID, SUM(quantity * maxprice) AS total_cost
        FROM prescription p1
        INNER JOIN pharmacy p2 ON p1.pharmacyID = p2.pharmacyID
        INNER JOIN contain c ON c.prescriptionID = p1.prescriptionID
        INNER JOIN treatment t ON t.treatmentID = p1.treatmentID
        INNER JOIN medicine m ON m.medicineID = c.medicineID 
        WHERE YEAR(date) = year AND p2.pharmacyID = pharma_id
        GROUP BY p2.pharmacyID, p1.prescriptionID
    ) t;
    
    RETURN avg_price;
END $$
DELIMITER ;

select pharma_avg(6018,2021)

