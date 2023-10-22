-- Problem Statement 4: 
-- Jackson has requested a detailed pharmacy report that shows each pharmacy name, and how many prescriptions they have prescribed for each disease
--  in the year 2022, along with this Jackson also needs to view how many prescriptions were prescribed by each pharmacy, and the total number
--  prescriptions were prescribed for each disease.
-- Assist Jackson to create this report. 




SELECT  p.pharmacyname, d.diseasename, COUNT(pr.prescriptionid) AS prescriptions_count
FROM  pharmacy p
JOIN  prescription pr ON p.pharmacyid = pr.pharmacyid
JOIN  treatment t ON pr.treatmentid = t.treatmentid
JOIN  disease d ON t.diseaseid = d.diseaseid
WHERE YEAR(t.date) = 2022
GROUP BY p.pharmacyname, d.diseasename WITH ROLLUP;
    


-- select   p2.pharmacyName , d.diseaseName ,count(*) as total_prescription
-- from treatment t
-- inner join disease d on t.diseaseID = d.diseaseID 
-- inner join prescription p1 on p1.treatmentID = t.treatmentID
-- inner join pharmacy p2 on p2.pharmacyID = p1.pharmacyID
-- where year(t.date) =2022
-- group by p2.pharmacyID , p2.pharmacyName ,d.diseaseID , d.diseaseName with rollup;
