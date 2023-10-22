-- Problem Statement 2:  
-- Insurance companies want to evaluate the performance of different insurance plans they offer. 
-- Generate a report that shows each insurance plan, the company that issues the plan, and the number of treatments the plan was claimed for.
--  The report would be more relevant if the data compares the performance for different years(2020, 2021 and 2022) and if the report also includes 
--  the total number of claims in the different years, as well as the total number of claims for each plan in all 3 years combined.

select  i1.companyName ,i2.planName   ,  year(t.date) , count(*)
from insurancecompany i1
inner join insuranceplan i2 on i1.companyID = i2.companyID
inner join claim c on c.uin = i2.uin
inner join treatment t on t.claimID = c.claimID 
where year(date) in (2020,2021,2022)
group by i1.companyName ,i2.planName, year(date) with rollup


-- 5265
