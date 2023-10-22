-- Problem Statement 3: The healthcare department needs a report about insurance plans. The report is required to include the insurance plan, 
-- which was claimed the most and least for each disease.  Assist to create such a report.

with i_rank as (select t.diseaseID  , c.uin , i.planName ,count(*) as claim_count  ,
rank() over (partition by t.diseaseID order by count(*) desc ) as high_rank , rank() over (partition by t.diseaseID order by count(*)  ) as low_rank 
from treatment t
inner join claim c
on c.claimid = t.claimid 
inner join 
insuranceplan i
on c.uin = i.uin
where t.claimid is not null
group by t.diseaseID , c.uin
order by t.diseaseID , 4 desc) 

-- 
select diseaseID , uin , planname ,  claim_count as high_claim_count
from i_rank
where high_rank =1;

-- select diseaseID , uin , planname ,  claim_count as low_claim_count
-- from i_rank
-- where low_rank =1