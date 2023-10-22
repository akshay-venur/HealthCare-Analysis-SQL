-- Problem Statement 4:  The healthcare department wants a state-wise health report to assess which state requires more attention in the healthcare sector.
--  Generate a report for them that shows the state name, number of registered people in the state, number of registered patients in the state,
--  and the people-to-patient ratio. sort the data by people-to-patient ratio. 


WITH cte1 AS (
    SELECT a.state, COUNT(*) AS reg_people
    FROM address a
    INNER JOIN person p ON p.addressid = a.addressid
    GROUP BY a.state
), cte2 AS (
    SELECT a.state, COUNT(*) AS reg_patient
    FROM address a
    INNER JOIN person p ON p.addressid = a.addressid
    INNER JOIN patient p1 ON p1.patientid = p.personid
    GROUP BY a.state
)

SELECT c1.state, c1.reg_people, c2.reg_patient, ROUND((c2.reg_patient / c1.reg_people) * 100, 2) AS ratio
FROM cte1 c1
INNER JOIN cte2 c2 USING (state)
ORDER BY 4 DESC;








