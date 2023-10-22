
-- Problem Statement 5:  An Insurance company wants a state wise report
-- of the treatments to claim ratio between 1st April 2021 and 31st March 2022
--  (days both included). Assist them to create such a report.

WITH state_report AS (
    SELECT a.state, p2.patientID, t.treatmentID, t.claimid
    FROM person p1
    INNER JOIN address a ON a.addressid = p1.addressid
    INNER JOIN patient p2 ON p1.personid = p2.patientID
    INNER JOIN treatment t ON t.patientid = p2.patientid
    WHERE t.date BETWEEN '2021-04-01' AND '2022-03-31'
    ORDER BY a.state
), claim_summary AS (
    SELECT state, COUNT(*) AS total_treatment, SUM(CASE WHEN claimid IS NOT NULL THEN 1 ELSE 0 END) AS total_claim
    FROM state_report
    GROUP BY state
)

SELECT state, ROUND((total_claim / total_treatment) * 100, 2) AS claim_ratio
FROM claim_summary;
