-- Problem Statement 4:
-- Currently, the data from every state is not in the database, The management has decided to add the data from other states and cities as well. 
-- It is felt by the management that it would be helpful if the date and time were to be stored whenever new city or state data is inserted.
-- The management has sent a requirement to create a PlacesAdded table if it doesn’t already exist, that has four attributes. placeID, placeName, placeType,
--  and timeAdded.
--  
-- Description
-- placeID: This is the primary key, it should be auto-incremented starting from 1
-- placeName: This is the name of the place which is added for the first time
-- placeType: This is the type of place that is added for the first time. The value can either be ‘city’ or ‘state’
-- timeAdded: This is the date and time when the new place is added

-- You have been given the responsibility to create a system that satisfies the requirements of the management. Whenever some data is inserted in the
--  Address table that has a new city or state name, the PlacesAdded table should be updated with relevant data. 


-- create table placesAdded(
--   placeID INT AUTO_INCREMENT PRIMARY KEY,
--   placeName VARCHAR(100) NOT NULL,
--   placeType ENUM('city', 'state') NOT NULL,
--   timeAdded DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
-- );

-- create table address_copy as 
-- select * from address ;

       
DELIMITER $$

CREATE TRIGGER before_address_insert
BEFORE INSERT ON Address_copy
FOR EACH ROW
BEGIN
  DECLARE isCity BOOLEAN;
  DECLARE isState BOOLEAN;
  
  SET isCity = NEW.city IS NOT NULL;
  SET isState = NEW.state IS NOT NULL;
  
  IF isCity AND NOT isState THEN
    INSERT INTO PlacesAdded (placeName, placeType)
    VALUES (NEW.city, 'city');
  ELSEIF NOT isCity AND isState THEN
    INSERT INTO PlacesAdded (placeName, placeType)
    VALUES (NEW.state, 'state');
  END IF;
END;
$$

DELIMITER ;

insert into address_copy(addressid, address1,state)  values	(1234,'mangalore','Karnataka') ;
select * from placesadded;
