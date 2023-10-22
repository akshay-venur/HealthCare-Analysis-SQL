-- Problem Statement 5:
-- The representative of the pharma union, Aubrey, is trying to audit different aspects of the pharmacies. 
-- She has requested a system that can be used to find the average balance for claims submitted by a specific insurance company in the year 2022. 
-- Create a stored function that can be used in the requested application. 

DELIMITER $$
CREATE FUNCTION avg_balance(company_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE avg_claim_amount DECIMAL(10,2);
    
    SELECT  ROUND(AVG(c.balance), 2) INTO avg_claim_amount
    FROM treatment t 
    INNER JOIN claim c ON c.claimID = t.claimID
    INNER JOIN insuranceplan i1 ON i1.uin = c.uin
    WHERE YEAR(date) = 2022 AND i1.companyID = company_id
    GROUP BY companyID;
    
    RETURN avg_claim_amount;
END $$
DELIMITER ;

select avg_balance(5173);


