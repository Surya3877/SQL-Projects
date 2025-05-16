CREATE DATABASE IF NOT EXISTS Organization;
USE Organization;

# Q-1. Write An SQL Query To Fetch “FIRST_NAME” From Worker Table Using The Alias Name As <WORKER_NAME>.
SELECT
    First_Name as Worker_Name
FROM
    Worker;
    
# Q-2. Write An SQL Query To Fetch “FIRST_NAME” From Worker Table In Upper Case.
SELECT
    upper(First_Name)
FROM
    Worker;
    
# Q-3. Write An SQL Query To Fetch Unique Values Of DEPARTMENT From Worker Table.
SELECT
    DISTINCT Department as Unique_Values_Of_DEPARTMENT
FROM
    Worker;
    
# Q-4. Write An SQL Query To Print The First Three Characters Of  FIRST_NAME From Worker Table. 
SELECT
    substring(first_name, 1, 3) as First_Three_Characters_Of_FIRST_NAME
FROM
    Worker;
    
# Q-5. Write An SQL Query To Find The Position Of The Alphabet (‘A’) In The First Name Column ‘Amitabh’ From Worker Table. 
SELECT
    position('A' in First_Name) as Position_A
FROM
    Worker
WHERE
    First_Name = 'Amitabh';
    
# Q-6. Write An SQL Query To Print The FIRST_NAME From Worker Table After Removing White Spaces From The Right Side.
SELECT
    rtrim(First_Name) as First_Name_Trimmed
FROM
    Worker;
    
# Q-7. Write An SQL Query To Print The DEPARTMENT From Worker Table After Removing White Spaces From The Left Side.
SELECT
    ltrim(Department) as Department_Trimmed
FROM
    Worker;
    
# Q-8. Write An SQL Query That Fetches The Unique Values Of DEPARTMENT From Worker Table And Prints Its Length. 
SELECT
    DISTINCT Department as The_Unique_Values_Of_DEPARTMENT,
    length(Department) as  Its_Length
FROM
    Worker;
    
# Q-9. Write An SQL Query To Print The FIRST_NAME From Worker Table After Replacing ‘a’ With ‘K’.    (for replacing char is case-sensitive) 
SELECT
    replace(First_Name, 'a', 'k') as First_Name_Modified
FROM
    worker;
    
# Q-10. Write An SQL Query To Print The FIRST_NAME And LAST_NAME From Worker Table Into A Single Column COMPLETE_NAME. A Space Char Should Separate Them. 
SELECT
    concat(First_Name, ' ', Last_Name) as Complete_Name
FROM
    Worker;
    
# Q-11. Write An SQL Query To Print All Worker Details From The Worker Table Order By FIRST_NAME Ascending. 
SELECT
    *
FROM
    Worker
ORDER BY
    First_Name ASC;
    
# Q-12. Write An SQL Query To Print All Worker Details From The Worker Table Order By FIRST_NAME 
# Ascending And DEPARTMENT Descending.
SELECT
    *
FROM
    Worker
ORDER BY
    First_Name ASC,
    Department DESC;
    
# Q-13. Write An SQL Query To Print Details For Workers With The First Name As “Vipul” And “Satish” 
# From Worker Table.
SELECT
    *
FROM
    Worker
WHERE
    First_Name IN ('Vipul', 'Satish');

# Q-14. Write An SQL Query To Print Details Of Workers Excluding First Names, “Vipul” And “Satish” From 
# Worker Table.
SELECT
    *
FROM
    Worker
WHERE
    First_Name NOT IN ('Vipul', 'Satish');
    
# Q-15. Write An SQL Query To Print Details Of Workers With DEPARTMENT Name As “Admin”.
SELECT
    *
FROM
    Worker
WHERE
    Department = 'Admin';
    
# Q-16. Write An SQL Query To Print Details Of The Workers Whose FIRST_NAME Contains ‘A’. 
SELECT
    *
FROM
    Worker
WHERE
    First_Name LIKE '%A%';
    
# Q-17. Write An SQL Query To Print Details Of The Workers Whose FIRST_NAME Ends With ‘A’. 
SELECT
    *
FROM
    Worker
WHERE
    First_Name LIKE '%A';
    
# Q-18. Write An SQL Query To Print Details Of The Workers Whose FIRST_NAME Ends With ‘H’ And 
# Contains Six Alphabets.
SELECT
    *
FROM
    Worker
WHERE
    First_Name LIKE '%H'
AND
   length(First_Name) = 6;

# Q-19. Write An SQL Query To Print Details Of The Workers Whose SALARY Lies Between 100000 And 500000.
SELECT
    *
FROM
    Worker
WHERE
    Salary BETWEEN 100000 And 500000;

# Q-20. Write An SQL Query To Print Details Of The Workers Who Have Joined In Feb’2014. 
SELECT
    *
FROM
    worker
WHERE
    year(Joining_Date) = '2014'
AND
    month(Joining_Date) = '2';
    
# Q-21. Write An SQL Query To Fetch The Count Of Employees Working In The Department ‘Admin’.
SELECT
    count(*) as Count_Of_Employees_in_Department_Admin
FROM
    Worker
WHERE
    Department = 'Admin';
    
# Q-22. Write An SQL Query To Fetch Worker Names With Salaries >= 50000 And <= 100000. 
SELECT
    First_Name,
    Last_Name,
    Salary
FROM
    Worker
WHERE
    Salary BETWEEN 50000 AND 100000;
    
# Q-23. Write An SQL Query To Fetch The No. Of Workers For Each Department In The Descending Order. 
SELECT
	Department,
    count(*) as No_Of_Workers_For_Each_Department 
FROM
    Worker
GROUP BY
    Department
ORDER BY
   No_Of_Workers_For_Each_Department DESC;
   
# Q-24. Write An SQL Query To Print Details Of The Workers Who Are Also Managers. 
SELECT
    Worker.First_Name,
    Worker.Last_Name
FROM
    Worker
INNER JOIN
    Title
ON
    Worker.Worker_Id = Title.Worker_Ref_Id
WHERE
    Worker_Title = 'Manager';

# Q-25. Write An SQL Query To Fetch Duplicate Records Having Matching Data In Some Fields Of A Table. 
SELECT
    First_Name,
    Last_Name,
    count(*) as Count_Duplicate_Records
FROM
    Worker
GROUP BY
    First_Name,
    Last_Name
HAVING
    count(*) > 1;
    
# Q-26. Write An SQL Query To Show Only Odd Rows From A Table.
 
-- Method 1: Using ROW_NUMBER() (Recommended)
SELECT
    *
FROM
    (
        SELECT *,
            ROW_NUMBER() OVER (ORDER BY Worker_Id) as row_num
		FROM
            Worker
    ) as temp
WHERE
    row_num % 2 = 1;
    
--  Method 2: Using MOD() with Primary Key
SELECT
    *
FROM
    Worker
WHERE 
    mod(Worker_Id, 2) = 1;
    
# Q-27. Write An SQL Query To Show Only Even Rows From A Table. 
SELECT
    *
FROM
    (
        SELECT *,
		    ROW_NUMBER() OVER(ORDER BY Worker_id) as even_row
		FROM
            Worker
    ) as temp
WHERE
    even_row % 2 = 0;
    
# Q-28. Write An SQL Query To Clone A New Table From Another Table. 
CREATE TABLE Worker_Clone AS
SELECT 
    * 
FROM 
    Worker 
WHERE 
    1 = 0;
    
# Q-29. Write An SQL Query To Fetch Intersecting Records Of Two Tables.
SELECT 
     W.*
FROM 
     Worker W
INNER JOIN 
    Worker_Clone WC
ON 
    W.Worker_Id = WC.Worker_Id;
    
# Q-30. Write An SQL Query To Show Records From One Table That Another Table Does Not Have. 
SELECT W.*
FROM Worker W
LEFT JOIN Worker_Clone WC
ON W.Worker_Id = WC.Worker_Id
WHERE WC.Worker_Id IS NULL;

# Q-31. Write An SQL Query To Show The Current Date And Time. 
SELECT NOW() AS Current_DateTime;

# Q-32. Write An SQL Query To Show The Top N (Say 10) Records Of A Table. 
SELECT
    *
FROM
    Worker
ORDER BY
    Worker_Id 
LIMIT 
    10;
    
# Q-33. Write An SQL Query To Determine The Nth (Say N=5) Highest Salary From A Table. 
SELECT
    DISTINCT Salary as Highest_Salary_From_A_Table
FROM
    Worker
ORDER BY
    Salary DESC
LIMIT 
    1
OFFSET
    4;
    
# Q-34. Write An SQL Query To Determine The 5th Highest Salary Without Using TOP Or Limit Method. 
SELECT
    Salary as  5th_Highest_Salary 
FROM
    (
        SELECT
            Salary,
            DENSE_RANK() OVER (ORDER BY Salary DESC) as denrnk
		FROM
            Worker
    ) as Salary_rank
WHERE
   denrnk = 5; 
   
# Q-35. Write An SQL Query To Fetch The List Of Employees With The Same Salary.
SELECT
    Salary,
    count(*) as Employee_Count
FROM
    Worker
GROUP BY
    Salary
HAVING
    count(*) > 1;

# Q-36. Write An SQL Query To Show The Second Highest Salary From A Table. 
SELECT
    DISTINCT Salary as Second_Highest_Salary
FROM
    Worker
ORDER BY
    Salary DESC
    LIMIT 1 OFFSET 1;
    
-- Method 2 : Using CTE (Common Table Expression)?
WITH Ranked_Salaries as (
    SELECT
        salary,
        ROW_NUMBER() OVER (ORDER BY Salary DESC) as rnk
	FROM
        Worker
)
SELECT
    Salary as Second_Highest_Salary
FROM
    Ranked_Salaries
WHERE
    rnk = 2;
    
# Q-37. Write An SQL Query To Show One Row Twice In Results From A Table. 
SELECT
    *
FROM
    Worker
WHERE
    Worker_id = 1
UNION ALL
SELECT
    *
FROM
    Worker
WHERE
    Worker_id = 1;
    
# Q-38. Write An SQL Query To Fetch Intersecting Records Of Two Tables. 
SELECT
    *
FROM
    Worker
INNER JOIN
    Title
ON
    Worker.Worker_Id = Title.Worker_Ref_Id;

# Q-39. Write An SQL Query To Fetch The First 50% Records From A Table. 
SELECT *
FROM (
    SELECT *,
        ROW_NUMBER() OVER (ORDER BY Worker_Id) as row_num
	FROM
        Worker
) as temp
WHERE
    row_num <= (
        SELECT
            count(*) / 2
		FROM
            worker
    );
    
# Q-40. Write An SQL Query To Fetch The Departments That Have Less Than Five People In It. 
SELECT
    Department
FROM
    Worker
GROUP BY
    Department
HAVING
    count(*) < 5;
    
# Q-41. Write An SQL Query To Show All Departments Along With The Number Of People In There.
SELECT
    Department,
    count(*) as Number_of_Workers
FROM
    Worker
GROUP BY
    Department;
    
# Q-42. Write An SQL Query To Show The Last Record From A Table. 
SELECT
    *
FROM
    Worker
ORDER BY
    Worker_Id
LIMIT
    1;
    
# Q-43. Write An SQL Query To Fetch The First Row Of A Table. 
SELECT
    *
FROM
    Worker
ORDER BY
    Worker_Id ASC
LIMIT
    1;
    
# Q-44. Write An SQL Query To Fetch The Last Five Records From A Table. 
SELECT
    *
FROM
    Worker
ORDER BY
    Worker_id DESC
LIMIT
    5;
    
# Q-45. Write An SQL Query To Print The Name Of Employees Having The Highest Salary In Each 
# Department.
SELECT
    Worker.First_Name,
    Worker.Last_Name,
    Worker.Department,
    Worker.Salary
FROM
    Worker
WHERE
    Worker.Salary = (
        SELECT
            max(Salary)
		FROM
            Worker
		WHERE
            Department = Worker.Department
);

# Q-46. Write An SQL Query To Fetch Three Max Salaries From A Table. 
-- Fetching the Top 3 Maximum Salaries
SELECT
    Salary Three_Max_Salaries_From_A_Table
FROM
    Worker
ORDER BY
    Salary DESC
LIMIT 
    3;
    
-- Alternative Using ROW_NUMBER() (If You Need Row-Wise Ranking)
WITH Ranked_Salaries as (
    SELECT
        Salary,
        ROW_NUMBER() OVER (ORDER BY Salary DESC) as row_num
	FROM
        Worker
)
SELECT
    salary
FROM
    Ranked_Salaries
WHERE
    row_num <= 3;
    
WITH Ranked_Salaries as (
    SELECT
        Salary,
		DENSE_RANK() OVER (ORDER BY Salary DESC) as dens_rnk
	FROM
        Worker
)
SELECT
    Salary
FROM
    Ranked_Salaries
WHERE
    dens_rnk <= 3;
    
# Q-47. Write An SQL Query To Fetch Three Min Salaries From A Table. 
-- Fetching the Top 3 Maximum Salaries
SELECT
    DISTINCT Salary
FROM
    Worker
ORDER BY
    Salary ASC
LIMIT
    3;
    
# Alternative Using ROW_NUMBER() (If You Need Row-Wise Ranking)
WITH Ranked_Salaries as (
     SELECT
         Salary,
         ROW_NUMBER() OVER (ORDER BY Salary ASC) as row_num
	FROM
        Worker
)
SELECT
   Salary
FROM
    Ranked_Salaries
WHERE
    row_num <= 3;

-- Alternative Using DENSE_RANK() (If There Are Ties)
WITH Ranked_Salaries as (
    SELECT
        Salary,
        DENSE_RANK() OVER (ORDER BY Salary ASC) as dens_rnk
	FROM
        Worker
)
SELECT
    Salary
FROM
    Ranked_Salaries
WHERE
    dens_rnk <= 3;

# Q-48. Write An SQL Query To Fetch Nth Max Salaries From A Table. 
-- 1️. Using LIMIT and OFFSET (Basic Approach)
SELECT
    Salary
FROM
    Worker
ORDER BY
    Salary DESC
LIMIT
     1
OFFSET
     1;
     
# 2️. Using ROW_NUMBER() (Unique Ranking)
WITH Ranked_Salaries as (
    SELECT
        Salary,
        ROW_NUMBER() OVER (ORDER BY Salary DESC) as row_num
	FROM
        Worker
)
SELECT
    Salary
FROM
    Ranked_Salaries
WHERE
    row_num = 5;
    
-- Using DENSE_RANK() (Handles Salary Ties)
WITH Ranked_Salaries as (
    SELECT
        Salary,
        DENSE_RANK() OVER (ORDER BY Salary DESC) as dens_rnk
	FROM
        Worker
)
SELECT
    Salary
FROM
    Ranked_Salaries
WHERE
    dens_rnk = 5;

# Q-49. Write An SQL Query To Fetch Departments Along With The Total Salaries Paid  
SELECT
    Department,
    sum(Salary) as Total_Salaries_Paid
FROM
    Worker
GROUP BY
    Department
ORDER BY
    Total_Salaries_Paid DESC;
    
# Q-50. Write An SQL Query To Fetch The Names Of Workers Who Earn The Highest Salary. 
SELECT
    First_Name,
    Last_Name,
    Salary
FROM
    Worker
WHERE
    Salary = (
        SELECT
            max(Salary)
		FROM
            Worker
    );
    
-- Alternative Approach Using DENSE_RANK()
WITH Ranked_Salaries as (
    SELECT
	    First_Name,
        Last_Name,
        Salary,
        DENSE_RANK() OVER (ORDER BY Salary DESC) as dens_rnk
	FROM
        Worker
)
SELECT
    First_Name,
    Last_Name,
    Salary
FROM
    Ranked_Salaries
WHERE
    dens_rnk = 1;
	


    
        
    
 
        
        
    
