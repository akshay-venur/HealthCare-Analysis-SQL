-- Problem Statement 1: 
-- Insurance companies want to know if a disease is claimed higher or lower than average.  Write a stored procedure that returns
--  “claimed higher than average” or “claimed lower than average” when the diseaseID is passed to it. 
-- Hint: Find average number of insurance claims for all the diseases.  If the number of claims for the passed disease is higher than the average
--  return “claimed higher than average” otherwise “claimed lower than average”.

delimiter $$ 
create procedure disease_category (in diseaseid int )
begin
		DECLARE avg_claims DECIMAL(10, 2);
		DECLARE disease_claims INT;
        
		select avg(claim_count) into avg_claims from (
		select d.diseaseID  ,d.diseaseName ,  (count(*)) as claim_count
		from treatment t
		inner join claim c on c.claimid = t.claimid
		inner join disease d on d.diseaseID = t.diseaseID
		group by d.diseaseID ) t ;
        
        SELECT COUNT(*) INTO disease_claims
		FROM treatment t
		INNER JOIN claim c ON c.claimid = t.claimid
		WHERE t.diseaseID = diseaseid;
        
        IF disease_claims > avg_claims THEN
			SELECT 'claimed higher than average' AS claim_status;
		ELSE
			SELECT 'claimed lower than average' AS claim_status;
		  END IF;

end
$$
delimiter ;

CALL disease_category(40);

