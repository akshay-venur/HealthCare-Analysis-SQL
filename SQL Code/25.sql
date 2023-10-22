-- Problem Statement 5:  
-- Walde, from Rock tower insurance, has sent a requirement for a report that presents which insurance company is targeting the patients 
-- of which state the most. 
-- Write a query for Walde that fulfills the requirement of Walde.
-- Note: We can assume that the insurance company is targeting a region more if the patients of that region are claiming more insurance of that company.

with cte as (select a.state  , i1.companyID , i2.companyName,count(*) as total_claim,
rank() over(partition by i2.companyID  order by count(*) desc) claim_rank
from person p1
inner join
address a
on a.addressid = p1.addressid
inner join
patient p2
on p2.patientid = p1.personid
inner join 
treatment t
on p2.patientID = t.patientID
inner join 
claim c
on c.claimid = t.claimid
inner join
insuranceplan i1
on i1.uin = c.uin
inner join 
insurancecompany i2
on i1.companyID = i2.companyID 
group by i2.companyid , state
order by i2.companyname desc  ,  count(*) desc )

select companyid , companyname ,state,  total_claim 
from cte
where claim_rank =1 ;




