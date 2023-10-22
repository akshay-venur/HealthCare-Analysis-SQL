-- Problem Statement 4:
-- The representative of the pharma union, Aubrey, has requested a system that she can use to find how many people in a specific city
--  have been treated for a specific disease in a specific year.
-- Create a stored function for this purpose.

delimiter $$
create function city_report (city_name varchar(20) , disease_id int , year int )
returns int 
deterministic
begin 
		declare disease_count int ;
        select count(*) as disease_count into disease_count
        from address a 
        inner join person p1 on p1.addressid = a.addressID
        inner join patient p2 on p1.personID = p2.patientID
        inner join treatment t on t.patientID = p2.patientID
        inner join disease d on t.diseaseID = d.diseaseID 
        where a.city = city_name and d.diseaseID = disease_id and year(date) = year
		--  where a.city = 'Washington' and d.diseaseID = 6 and year(date) = 2021
        group by city , d.diseaseID , d.diseaseName; 
        
        return disease_count;
        
end $$
delimiter ;

select city_report('Washington',6,2021)  as total_disease_count ;