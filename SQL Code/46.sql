-- Problem Statement 1:
-- The healthcare department has requested a system to analyze the performance of insurance companies and their plan.
-- For this purpose, create a stored procedure that returns the performance of different insurance plans of an insurance company.
--  When passed the insurance company ID the procedure should generate and return all the insurance plan names the provided company issues, 
--  the number of treatments the plan was claimed for, and the name of the disease the plan was claimed for the most. The plans which are claimed 
--  more are expected to appear above the plans that are claimed less.

DELIMITER $$
CREATE PROCEDURE get_insurance_claim(IN company_id INT)
BEGIN

    WITH cte AS (
        SELECT i1.companyID, i1.companyName, i2.uin, i2.planName, t.diseaseID ,d.diseaseName
        FROM insurancecompany i1
        LEFT JOIN insuranceplan i2 ON i1.companyID = i2.companyID 
        LEFT JOIN claim c ON c.uin = i2.uin
        LEFT JOIN treatment t ON t.claimID = c.claimID
        inner join disease d on d.diseaseID = t.diseaseID
        WHERE i1.companyID = company_id 
    ), 
    cte2 AS (
        SELECT companyID, companyName, uin, planName, COUNT(*) AS claim_count
        FROM cte
        GROUP BY companyid, uin
    ), 
    cte3 AS (
        SELECT companyID, companyName, uin, planName, diseaseid, diseaseName, COUNT(*) AS disease_count,
        RANK() OVER (PARTITION BY companyID, uin ORDER BY COUNT(*) DESC) AS d_rank
        FROM cte
        GROUP BY companyid, uin, diseaseid
    )
    
    SELECT a.companyID, a.companyName, a.uin, a.planName, claim_count, GROUP_CONCAT(diseaseName) AS diseases
    FROM cte2 a
    INNER JOIN cte3 b ON a.companyID = b.companyid AND a.uin = b.uin
    WHERE d_rank = 1
    GROUP BY a.companyid, a.uin;
END $$
DELIMITER ;

call get_insurance_claim(1409) ;

-- select * from insurancecompany

select * from disease
where diseaseID in (7,23,40);


