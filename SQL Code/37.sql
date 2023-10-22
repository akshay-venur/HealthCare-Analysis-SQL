-- Query 2: 
-- For each city, Find the number of registered people, number of pharmacies, and number of insurance companies.

-- drop table if exists T1;
-- drop table if exists T2;
-- drop table if exists T3;

-- select Address.city, count(Pharmacy.pharmacyID) as numPharmacy
-- into T1
-- from Pharmacy right join Address on Pharmacy.addressID = Address.addressID
-- group by city
-- order by count(Pharmacy.pharmacyID) desc;

-- select Address.city, count(InsuranceCompany.companyID) as numInsuranceCompany
-- into T2
-- from InsuranceCompany right join Address on InsuranceCompany.addressID = Address.addressID
-- group by city
-- order by count(InsuranceCompany.companyID) desc;

-- select Address.city, count(Person.personID) as numRegisteredPeople
-- into T3
-- from Person right join Address on Person.addressID = Address.addressID
-- group by city
-- order by count(Person.personID) desc;

-- select T1.city, T3.numRegisteredPeople, T2.numInsuranceCompany, T1.numPharmacy
-- from T1, T2, T3
-- where T1.city = T2.city and T2.city = T3.city
-- order by numRegisteredPeople desc;

-- table dropped , so t1,t2, t3 considered as variable . It will give error that undeclared varibale T1. 
-- query can be optimized by using LEFT JOIN instead of RIGHT JOIN and removing unnecessary intermediate temporary tables (T1, T2, T3). 
-- we are using COUNT(DISTINCT ...) to ensure that we count distinct IDs for each entity (pharmacy, insurance company, and registered person) within a city.

SELECT
    Address.city,
    COUNT(DISTINCT Pharmacy.pharmacyID) AS numPharmacy,
    COUNT(DISTINCT InsuranceCompany.companyID) AS numInsuranceCompany,
    COUNT(DISTINCT Person.personID) AS numRegisteredPeople
FROM
    Address
LEFT JOIN Pharmacy ON Pharmacy.addressID = Address.addressID
LEFT JOIN InsuranceCompany ON InsuranceCompany.addressID = Address.addressID
LEFT JOIN Person ON Person.addressID = Address.addressID
GROUP BY
    Address.city
ORDER BY
    numRegisteredPeople DESC;



