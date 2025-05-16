create database if not exists Insurance;
use Insurance;
select *
from insurance;

# 1. Count for each categories of ‘region.
select region, count(region) as Count_of_region
from insurance
group by region;

# 2. Find 50 records of highest ‘age’ and export data/table to desktop
select
    id,
    age
from insurance
order by age desc
limit 50;

# 3. Add index name ‘quick’ on ‘id’.
create index quick on insurance(id);

# 4. Describe the schema of table.
describe insurance;

# 5. Create view name as ‘gender’ where users can not see ‘sex’ [Hint: first runappropriate query then create view] 
select id, age, bmi, children, smoker, region, charges
from insurance;

create	view gender as (
select id, age, bmi, children, smoker, region, charges
from insurance); 

select *
from gender; 

# 6. Rename the view as ‘type’.
rename table gender to type;

# 7. Count how many are ‘northwest’ insurance holders.
select
    region, count(region) as count_northwest_insurance_holders
from insurance
group by region
having region = 'northwest';

# 8. Count how many insurance holders were ‘femail’.
select
    sex, count(sex) as count_insurance_holders_were_female
from insurance
group by sex
having sex = 'female';

# 9. Create Primary key on a suitable column.
select * 
from insurance;
alter table insurance
add constraint primary key (id);

# 10. Create a new column ‘ratio’ which is age multiply by bmi.
alter table insurance
add column ratio varchar(30) after bmi;
update insurance
set ratio = age*bmi;
select *
from insurance;

# 11. Arrange the table from high to low according to charges.
select *
from insurance
order by charges desc;

# 12. Find MAX of ‘charges’.
select max(charges) as Max_of_Charges
from insurance;

# 13. Find MIN of ‘charges’.
select min(charges) as Min_of_Charges
from insurance;

# 14. Find average of ‘charges’ of male and female.
select
    sex, 
    avg(charges) as  Average_Charges_of_Male_and_Female
from insurance
group by sex;

# 15. Write a Query to rename column name sex to Gender 
alter table insurance
change column sex gender varchar(10);
select *
from insurance;

# 16. Add new column as HL_Charges where more than average charges should be 
# categorized as HIGH and less than average charges should be categorized as LOW.
alter table insurance
add column HL_Charges varchar(10);
update insurance
set HL_Charges = case
when(
    select avg(Charges)) > Charges then 'High'
    else 'Low'
    end;
select *, case when (select avg(charges) from insurance) >charges then 'high' else 'low' end as HL_charges from insurance;
select charges, avg(sum(charges)) from insurance group by insurance;
select * from insurance ;

# 17. Change location/position of ‘smoker’ and bring before ‘children’.
alter table insurance
modify column smoker varchar(10) after ratio;

# 18. Show top 20 records.
select *
from insurance
order by id asc limit 20;

# 19. Show bottom 20 records.
select *
from insurance
order by id desc limit 20;

# 20. Randomly select 20% of records and export to desktop.
select * 
from insurance 
where ID <= (select (count(*)/5) from insurance);

# 21. Remove column ‘ratio’.
alter table insurance
drop column ratio;
select *
from insurance;

# 22. Craete one example of Sub Queries involving ‘bmi’ and ‘sex’ and give explanation in 
# the script itself with remarks by using.
select * from insurance;
select smoker from insurance where smoker = 'yes' in (
select smoker,(
select gender, count(gender) as count_of_female from insurance group by gender having gender = 'female')as t);

# 23. Create a view called Female_HL_Charges that shows only those data where 
# HL_Charges is High, Female, Smokers and with 0 children.
select * from insurance;
select * from insurance where HL_charges = 'high' and smoker='yes' in(
select gender , children from insurance where gender='female' and children =0);

#24. Update children column if there is 0 children then make it as Zero Children, if 1 then one_children, if 2 then two_children,
# if 3 then three_children, if 4 then four_children if 5 then five_children else print it as More_than_five_children. 
select *, case when children = 0 then 'zero_children' when children = 1 then '1_children' when children = 2 then '2_children'
when children = 3 then '3_children' when children = 4 then '4_children' when children = 5 then '5_children'
 else '5-children' end as count_of_children from insurance;


