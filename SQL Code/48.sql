-- Problem Statement 3:
-- Jacob, as a business strategist, wants to figure out if a state is appropriate for setting up an insurance company or not.
-- Write a stored procedure that finds the num_patients, num_insurance_companies, and insurance_patient_ratio, the stored procedure
--  should also find the avg_insurance_patient_ratio and if the insurance_patient_ratio of the given state is less than the avg_insurance_patient_ratio
--  then it Recommendation section can have the value “Recommended” otherwise the value can be “Not Recommended”.

-- Description of the terms used:
-- num_patients: number of registered patients in the given state
-- num_insurance_companies:  The number of registered insurance companies in the given state
-- insurance_patient_ratio: The ratio of registered patients and the number of insurance companies in the given state
-- avg_insurance_patient_ratio: The average of the ratio of registered patients and the number of insurance for all the states.

delimiter $$
create procedure state_recommendation(in state_name varchar(20))
begin
	
    declare recommendation varchar(20);
    
	with cte1 as (select state , count(*) as total_patient
	from address a
	inner join person p1 on p1.addressID = a.addressID
	inner join patient p2 on p1.personID = p2.patientID
	group by state
	order by 2 desc),

	cte2 as (select state , count(*) as no_insurance_company
	from address a 
	inner join insurancecompany i1 on i1.addressID = a.addressID
	group by state
	order by 2 desc),-- AR no insurance company 

	cte3 as (
	select a.state , round(ifnull(total_patient /no_insurance_company,0),2) as ratio , 
	avg(round(ifnull(total_patient /no_insurance_company,0),2)) over () as avg_ratio
	from cte1 a
	left join 
	cte2 b
	on a.state = b.state
	order by 2 desc)
    
    select 
    case when ratio < avg_ratio then 'Recommended'
		 else 'Not Recommended' end as rec into recommendation 
	from cte3 where state = state_name ;
    
    select recommendation ;
end $$
delimiter ;

call state_recommendation('CT');


