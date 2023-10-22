WITH cte AS (
    SELECT
        i1.companyname,
        i2.planname,
        COUNT(*) AS claim_count,
        RANK() OVER (PARTITION BY i1.companyname ORDER BY COUNT(*) DESC) AS high_claim_rank,
        RANK() OVER (PARTITION BY i1.companyname ORDER BY COUNT(*)) AS low_claim_rank
    FROM insurancecompany i1
    INNER JOIN insuranceplan i2 ON i1.companyID = i2.companyID
    INNER JOIN claim c ON c.uin = i2.uin 
    INNER JOIN treatment t ON t.claimid = c.claimid
    GROUP BY i2.planname, i1.companyname
)
SELECT
    companyname,
    GROUP_CONCAT(planname ORDER BY claim_count DESC) AS most_claimed_plans,
    MAX(claim_count) AS max_claim_count,
    GROUP_CONCAT(planname ORDER BY claim_count) AS least_claimed_plans,
    MIN(claim_count) AS min_claim_count
FROM cte
WHERE high_claim_rank = 1 OR low_claim_rank = 1
GROUP BY companyname;
