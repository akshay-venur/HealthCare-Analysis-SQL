-- Problem Statement 1:
-- Patients are complaining that it is often difficult to find some medicines. They move from pharmacy to pharmacy to get the required medicine. 
-- A system is required that finds the pharmacies and their contact number that have the required medicine in their inventory. 
-- So that the patients can contact the pharmacy and order the required medicine.
-- Create a stored procedure that can fix the issue.

delimiter $$
create procedure find_pharma(in medicine_name varchar(20))
begin
	SET @medicine_name_pattern = CONCAT('%', medicine_name, '%');
	select p1.pharmacyName , p1.phone , m.medicineID , k.quantity , m.productName
	from pharmacy p1
	inner join keep k on k.pharmacyID = p1.pharmacyID
	inner join medicine m on m.medicineID = k.medicineID
	where m.productName like @medicine_name_pattern;

end $$
delimiter ;

call find_pharma('FAUL');