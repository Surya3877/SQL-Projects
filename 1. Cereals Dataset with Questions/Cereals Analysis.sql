create database if not exists Cereals;
use Cereals;

# 1. Add index name fast on name.
create index fast on cereals_data (name);

# 2. Describe the schema of table.
describe cereals_data;

# 3. Create view name as see where users can not see type column [first run appropriate query then create view]  
create view see as
(select name, mfr, calories, HL_calories,protein,sodium,carbo,sugars,potass,vitamins,shelf,weight,cups,rating from cereals_data);
select * from see;


# 4. Rename the view as saw 
DROP VIEW IF EXISTS see;
CREATE VIEW saw AS
SELECT mfr, calories, protein, fat, sodium, fiber, carbo, sugars, potass, vitamins, shelf, weight, cups, rating
FROM cereals;
DESCRIBE saw;
SELECT * FROM saw; 

#5. Count how many are cold cereals 
select type, count(type) as C_H from cereals_data group by type;

#6. Count how many cereals are kept in shelf 3 
select * from cereals_data;
select shelf, count(shelf) as Shelf_3 from cereals_data group by shelf having shelf = 3;

#7. Arrange the table from high to low according to ratings  
select * from cereals_data order by rating desc;

#9. Find average of calories of hot cereal and cold cereal in one query  
select type,avg(calories) as AVG_OF_HC from cereals_data group by type;

#10. Add new column as HL_Calories where more than average calories 
#should be categorized as HIGH and less than average calories should be categorized as LOW  
alter table cereals_data add column HL_calories varchar(15) after calories;
update cereals_data set HL_calories = case when calories < (select avg(calories)) then 'high' 
when calories > (select avg(calories)) then 'lw' end;
select * from cereals_data;
select avg(calories) from cereals_data;

#11. List only those cereals whose name begins with B  
select name from cereals_data where name like 'b%';

#12. List only those cereals whose name begins with F
select name from cereals_data where name like 'f%';
  
#13. List only those cereals whose name ends with s
select name from cereals_data where name like '%s';
  
#14. Select only those records which are HIGH in column HL_calories
select * from cereals_data;
alter table cereals_data add column HL_calories varchar(15) after calories;
update cereals_data set HL_calories = case when calories >(select avg(calories) from cereals_data) then 'high'
when calories <(select avg(calories)) then 'low'end;


update cereals_data set HL_calories = case when (select avg(calories)) > calories then 'high'
else 'low'end;
select avg(calories) from cereals_data;

  
#15. Find maximum of ratings
select max(rating) from cereals_data;
  
#16. Find average ratings of those were High and Low calories
select  HL_calories, avg(HL_calories) as result from cereals_data group by HL_calories;

#17. Craete two examples of Sub Queries of your choice and give explanation in the script itself with remarks by using #  
select * from cereals_data where calories <
(select calories from cereals_data where name = 'almond_delight');

select calories,shelf from cereals_data where calories in(
select calories from cereals_data where shelf = 3);

#18. Remove column fat
select * from cereals_data;
alter table cereals_data drop column fat; 

#19. Count records for each manufacturer [mfr]  
select mfr, count(mfr) as Count_MFR from cereals_data group by mfr;

#20. Select name, calories and ratings only 
select name, calories, rating from cereals_data;