-- Problem Statement 2: Insurance companies want to assess the performance of their insurance plans.
--  Generate a report that shows each insurance plan, the company that issues the plan, and the number of treatments the plan was claimed for.

select i2.planname , i1.companyname   ,count(*) as claim_count
from insurancecompany i1
inner join 
insuranceplan i2
on i1.companyID = i2.companyID
inner join
claim c
on c.uin = i2.uin 
inner join
treatment t
on t.claimid = c.claimid
group by i2.planname ,  i1.companyname 
order by 3 desc



