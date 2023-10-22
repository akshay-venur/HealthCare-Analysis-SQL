-- Problem Statement 1: 
-- “HealthDirect” pharmacy finds it difficult to deal with the product type of medicine being displayed in numerical form,
--  they want the product type in words. Also, they want to filter the medicines based on tax criteria. 
-- Display only the medicines of product categories 1, 2, and 3 for medicines that come under tax category I and medicines
--  of product categories 4, 5, and 6 for medicines that come under tax category II.
-- Write a SQL query to solve this problem.
-- ProductType numerical form and ProductType in words are given by
-- 1 - Generic, 
-- 2 - Patent, 
-- 3 - Reference, 
-- 4 - Similar, 
-- 5 - New, 
-- 6 - Specific,
-- 7 - Biological, 
-- 8 – Dinamized

-- 3 random rows and the column names of the Medicine table are given for reference.
-- Medicine (medicineID, companyName, productName, description, substanceName, productType, taxCriteria, hospitalExclusive, governmentDiscount, taxImunity, maxPrice)

with product_type as (
	select  *,
    case 
		when producttype =1 then 'Generic'
        when producttype =2 then 'Patent'
        when producttype =3 then 'Reference'
        when producttype =4 then 'Similar'
        when producttype =5 then 'New'
        when producttype =6 then 'Specific'
        when producttype =7 then 'Biological'
        when producttype =8 then 'Dinamized'
	end as product_category
    from medicine )

select *
from product_type
where taxcriteria ='I' and product_category in ('Generic','Patent','Reference')
union
select *
from product_type
where taxcriteria ='II' and product_category in ('Similar','New','Specific') ;


        
