-- Problem Statement 1:  Jimmy, from the healthcare department, has requested a report that shows how the number of treatments each age category 
-- of patients has gone through in the year 2022. 
-- The age category is as follows, Children (00-14 years), Youth (15-24 years), Adults (25-64 years), and Seniors (65 years and over).
-- Assist Jimmy in generating the report. 


with t_age as (select  p.patientid , TIMESTAMPDIFF(YEAR, p.dob,t.date) as t_age
from treatment t
left join
patient p 
on p.patientID = t.patientID
where year(date) =2022) ,
age_group as (
			select * , 
            case when t_age between 0 and 14 then 'children'
						 when t_age between 15 and 24 then 'Youth'
                         when t_age between 25 and 64 then 'Adults'
                         else 'Seniors'
                         end 
                         as age_groups
                         from t_age
)

-- select * from age_group
select age_groups , count(*) as age_group_count
from age_group 
group by age_groups  -- 2967

