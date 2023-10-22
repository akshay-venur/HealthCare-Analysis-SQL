-- Bharat is researching the impact of gender on different diseases, He wants to analyze
--  if a certain disease is more likely to infect a certain gender or not.
-- Help Bharat analyze this by creating a report showing for every disease how many 
-- males and females underwent treatment for each in the year 2021. It would also
--  be helpful for Bharat if the male-to-female ratio is also shown.

WITH d_group AS (
    SELECT p1.personid, p1.gender, t.treatmentID, d.diseaseID, d.diseaseName
    FROM person p1
    INNER JOIN patient p2 ON p1.personid = p2.patientid
    INNER JOIN treatment t ON p2.patientID = t.patientID
    INNER JOIN disease d ON d.diseaseID = t.diseaseID
    WHERE YEAR(t.date) = 2021
),
gender_count AS (
    SELECT diseaseID, diseaseName, gender, COUNT(*) AS d_count
    FROM d_group
    GROUP BY diseaseid, gender
),
disease_gender_ratio AS (
    SELECT
        diseaseID,
        diseaseName,
        SUM(CASE WHEN gender = 'Male' THEN d_count ELSE 0 END) AS male_count,
        SUM(CASE WHEN gender = 'Female' THEN d_count ELSE 0 END) AS female_count
    FROM gender_count
    GROUP BY diseaseID, diseaseName
)
SELECT
    dr.diseaseID,
    dr.diseaseName,
    dr.male_count,
    dr.female_count,
    ROUND(dr.male_count / NULLIF(dr.female_count, 0), 2) AS male_to_female_ratio
FROM disease_gender_ratio dr;
