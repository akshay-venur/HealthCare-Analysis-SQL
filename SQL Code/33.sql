-- Problem Statement 3:  
-- The insurance companies want a report on the claims of different insurance plans. 
-- Write a query that finds the top 3 most and top 3 least claimed insurance plans.
-- The query is expected to return the insurance plan name, the insurance company name which has that plan, 
-- and whether the plan is the most claimed or least claimed. 

## recheck

with cte as (select  i1.uin , i1.planName , i2.companyID , i2.companyName , count(*) as total_claim,
dense_rank() over (order by count(*) desc) as claim_h_rank , 
dense_rank() over (order by count(*) ) as claim_l_rank  
from treatment t
inner join claim c on c.claimID = t.claimID
inner join insuranceplan i1 on i1.uin = c.uin
inner join insurancecompany i2 on i2.companyID = i1.companyID
group by companyID , uin 
order by 5 desc )

select  planName, companyName, total_claim,
case 
	when claim_h_rank <=3 then 'most_claimed_plan' 
    when claim_l_rank<=3 then 'least_claimed_plan'
    end as category
 from cte
where claim_h_rank <=3 or claim_l_rank<=3
