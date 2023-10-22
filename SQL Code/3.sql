-- Problem Statement 3: Jacob, from insurance management, has noticed that insurance claims are not made for all the treatments.
--  He also wants to figure out if the gender of the patient has any impact on the insurance claim. 
--  Assist Jacob in this situation by generating a report that finds for each gender the number of treatments, number of claims, and treatment-to-claim ratio.
--  And notice if there is a significant difference between the treatment-to-claim ratio of male and female patients.

select * from treatment;

with gender_category as (select t.patientid , p1.gender  as gender ,t.treatmentID , t.claimID
from person p1
inner join
patient p2
on p1.personid  = p2.patientid
inner join
treatment t
on p2.patientID = t.patientID),

-- gender wise treatment count  -- male 6679 , female 4206
gender_treatment as (select gender , count(*) as gender_count_treatment
from gender_category
group by gender) ,

-- gender wise claims  -- male 4287 female 2676
gender_claim as (select gender  , count(*) as gender_claim_count
from gender_category 
where claimID is not null
group by gender)

-- gender wise claim ratio
select g1.gender,gender_count_treatment, gender_claim_count , round((gender_claim_count/gender_count_treatment)*100,2) as treatment_claim_ratio
from gender_treatment  g1
inner join
gender_claim g2
on g1.gender = g2.gender ;







