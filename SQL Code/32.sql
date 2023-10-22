-- Problem Statement 2:  
-- Joseph from Healthcare department has requested for an application which helps him get genderwise report for any disease. 
-- Write a stored procedure when passed a disease_id returns 4 columns,
-- disease_name, number_of_male_treated, number_of_female_treated, more_treated_gender
-- Where, more_treated_gender is either ‘male’ or ‘female’ based on which gender underwent more often for the disease, if the number is 
-- same for both the genders, the value should be ‘same’.
DELIMITER $$
CREATE PROCEDURE genderreport(IN diseaseID_param INT)
BEGIN
  DECLARE disease_name VARCHAR(100);
  DECLARE male_count INT;
  DECLARE female_count INT;
  DECLARE total_count INT;
  DECLARE more_treated_gender VARCHAR(6);
  
  SELECT
    d.diseasename,
    COUNT(*) AS total_count,
    SUM(CASE WHEN p2.gender = 'Male' THEN 1 ELSE 0 END) AS male_patients,
    SUM(CASE WHEN p2.gender = 'Female' THEN 1 ELSE 0 END) AS female_patients
  INTO
    disease_name,
    total_count,
    male_count,
    female_count
  FROM treatment t
  INNER JOIN patient p1 ON p1.patientID = t.patientID 
  INNER JOIN person p2 ON p2.personID = p1.patientID
  INNER JOIN disease d ON d.diseaseID = t.diseaseID
  WHERE t.diseaseID = diseaseID_param
  GROUP BY d.diseasename;
  
  IF male_count > female_count THEN
    SET more_treated_gender = 'male';
  ELSEIF male_count < female_count THEN
    SET more_treated_gender = 'female';
  ELSE
    SET more_treated_gender = 'same';
  END IF;
  
  SELECT
    disease_name,
    total_count,
    male_count,
    female_count,
    more_treated_gender;
    
END $$
DELIMITER ;

call genderreport(17);