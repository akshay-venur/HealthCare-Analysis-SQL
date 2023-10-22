-- Problem Statement 5:
-- Some pharmacies suspect there is some discrepancy in their inventory management. The quantity in the ‘Keep’ is updated regularly and there 
-- is no record of it. They have requested to create a system that keeps track of all the transactions whenever the quantity of the inventory is updated.
-- You have been given the responsibility to create a system that automatically updates a Keep_Log table which has  the following fields:
-- id: It is a unique field that starts with 1 and increments by 1 for each new entry
-- medicineID: It is the medicineID of the medicine for which the quantity is updated.
-- quantity: The quantity of medicine which is to be added. If the quantity is reduced then the number can be negative.
-- For example:  If in Keep the old quantity was 700 and the new quantity to be updated is 1000, then in Keep_Log the quantity should be 300.
-- Example 2: If in Keep the old quantity was 700 and the new quantity to be updated is 100, then in Keep_Log the quantity should be -600.


-- create table keep_copy  as 
-- select * from keep ;

-- create table keep_log(
-- 		id int auto_increment primary key,
--         medicineid int  references keep_copy(medicineid),
--         quantity int );
        
DELIMITER //

CREATE TRIGGER before_keep_copy_update
BEFORE UPDATE ON keep_copy
FOR EACH ROW
BEGIN
  DECLARE old_quantity INT;
  DECLARE quantity_difference INT;
  
  -- Fetch the old quantity for the particular medicineID and pharmacyID
  SELECT quantity INTO old_quantity
  FROM keep_copy
  WHERE pharmacyID = OLD.pharmacyID AND medicineID = OLD.medicineID;
  
  -- Calculate the quantity difference between old and new quantity
  SET quantity_difference = NEW.quantity - old_quantity;
  
  -- Insert the quantity difference into the keep_log table
  INSERT INTO keep_log (medicineID, quantity)
  VALUES (OLD.medicineID, quantity_difference);
END;
//

DELIMITER ;


update keep_copy
set quantity = 5500
where pharmacyID = 1008 and medicineid = 1111 ;

-- select * from keep_copy;

select * from keep_log;





