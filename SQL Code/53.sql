-- Problem Statement 3:
-- The healthcare department has requested an application that finds out the disease that was spread the most in a state for a given year.
--  So that they can use the information to compare the historical data and gain some insight.
-- Create a stored function that returns the name of the disease for which the patients from a particular state had the most number of treatments
--  for a particular year. Provided the name of the state and year is passed to the stored function.


delimiter $$
create function disease_stat (state_name varchar(20) , year int )
returns varchar(50)
deterministic
begin 
	declare disease_name varchar(50) ;
    
	select diseasename into  disease_name from   (select state , d.diseaseID  ,  d.diseaseName , count(*) as disease_count,
    rank() over (partition by state order by count(*) desc) as d_rank
    from address a
    inner join person p1 on p1.addressID = a.addressid
    inner join patient p2 on p1.personID = p2.patientID
    inner join treatment t on t.patientID = p2.patientID
    inner join disease d on d.diseaseID = t.diseaseID 
    where year(date) = year and state = state_name
    group by state , d.diseaseID) t
    where t.d_rank = 1 ;
    
    return disease_name ; 

end  $$
delimiter ;

select disease_stat('AK',2021) as most_spread_disease ; 