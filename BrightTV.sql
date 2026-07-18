-- Databricks notebook source
USE CATALOG `bright-tv`;
USE SCHEMA brighttvdata;

SELECT * 
FROM bright_tv_userprofile
 LIMIT 100;

 -------------------------------------------------------------------------
-- Duplication Check-----------------------------------

SELECT
    COUNT(*) AS cnt,
    UserID
USE CATALOG `bright-tv`;
USE SCHEMA brighttvdata;

SELECT * 
FROM bright_tv_userprofile
 LIMIT 100;

 -------------------------------------------------------------------------
-- Duplication Check-----------------------------------

SELECT
    COUNT(*) AS cnt,
    UserID
FROM bright_tv_userprofile
GROUP BY UserID
HAVING COUNT(*) > 1;
-------------------------------------------------------------------------
-- Data Size Check-----------------------------------
SELECT COUNT(*) AS number_of_rows,
COUNT(DISTINCT UserID) AS number_subs
FROM bright_tv_userprofile;
-------------------------------------------------------------------------
-- NULL USERID Check Check-----------------------------------
SELECT COUNT(*) AS cnt
FROM bright_tv_userprofile
WHERE UserID IS NULL;
-------------------------------------------------------------------------
 
 SELECT DISTINCT Gender
 FROM bright_tv_userprofile; 

 SELECT COUNT(*)
FROM bright_tv_userprofile
WHERE gender=' ';

SELECT DISTINCT
    CASE
        WHEN Gender = 'None' THEN 'unknown'
        WHEN Gender = ' ' THEN 'unknown'
        WHEN Gender IS NULL THEN 'unknown'
        ELSE Gender
    END AS Sex
FROM bright_tv_userprofile;

SELECT DISTINCT
    CONCAT('[', Gender, ']') AS Gender_Value
FROM bright_tv_userprofile;
--------------------------------------------------
-- Checking why my first query did not apply.
-- The issue is data may have space and needs Trimming - update'.
SELECT DISTINCT Gender
FROM bright_tv_userprofile;
---------------------------------------------------
--RACE CHECK----------------------------
SELECT DISTINCT race
FROM bright_tv_userprofile;

SELECT COUNT(*) AS num_rows
FROM bright_tv_userprofile
WHERE Race IS NULL;

SELECT COUNT(DISTINCT UserID) AS subs,
       CASE
           WHEN Race = 'other' THEN 'unknown' ---  Replace other with unknown
           WHEN Race = 'None' THEN 'unknown'---  Replace None with unknown
           WHEN Race = ' ' THEN 'unknown'-----Replace empty with unknown
           WHEN Race IS NULL THEN 'unknown'-----Replace empty with unknown
           ELSE Race
       END AS ethnicity
FROM bright_tv_userprofile
GROUP BY ethnicity;
-----------------------------------------------------------------------------------------------
--- The above leaves the empty as blank and does not apply the condition, possible space in the data sheet and will need to be TRIM down - apply Trim to own project for submission
------------------------------------------------------------------------------

-- Province Check-----------------------------------
SELECT DISTINCT Province
FROM bright_tv_userprofile;

SELECT DISTINCT 
    CASE
        WHEN Province = 'None' THEN 'unknown'
        WHEN Province = ' ' THEN 'unknown' ----- The mistake of not writing code as '' and not adding space, will return all the NULLS with out the code name unknown.
        WHEN Province IS NULL THEN 'unknown'
        ELSE Province
    END AS Region
FROM bright_tv_userprofile;

-- Age Check-----------------------------------
SELECT MIN(Age) AS min_age,
       MAX(Age) AS max_age,
       AVG(Age) AS mean_age
FROM bright_tv_userprofile;

SELECT COUNT(*) AS cnt
FROM bright_tv_userprofile
WHERE age IS NULL;

SELECT
    CASE
        WHEN Age = 0 THEN 'Infant'
        WHEN Age BETWEEN 1 AND 12 THEN 'Kids'
        WHEN Age BETWEEN 13 AND 17 THEN 'Youth'
        WHEN Age BETWEEN 18 AND 35 THEN 'Young Adult'
        WHEN Age BETWEEN 36 AND 50 THEN 'Adults'
        WHEN Age > 50 AND Age <= 60 THEN 'Elder'
        ELSE 'Senior'
    END AS Age_Group
FROM bright_tv_userprofile;
------------------------------------------------------
-- Email Check-----------------------------------

SELECT
    UserID,

    CASE
        WHEN Email IS NOT NULL THEN 1
        ELSE 0
    END AS email_flag

FROM bright_tv_userprofile;
-- Contact Information Check-----------------------------------

SELECT
    UserID,

    CASE
        WHEN (Email IS NOT NULL)
             OR (Email <> '')
             OR (`Social Media Handle` NOT IN ('None', 'other'))
        THEN 1
        ELSE 0
    END AS email_flag,

    CASE
        WHEN (`Social Media Handle` IS NOT NULL)
             OR (`Social Media Handle` <> '')
             OR (`Social Media Handle` NOT IN ('None', 'other'))
        THEN 1
        ELSE 0
    END AS social_media_flag
FROM bright_tv_userprofile;
-------------------------------------------------------------------------
-----------------------------------------------------------------------
--- Data Types
----------------------------------
----- int (integer) is a number without a decimal (0787372565)
--- str(string/objects) is a combination of character (a-z, 0-9,/,>.)
----DateTime, Timestamp,-its a Date
------------------------------------------------------------------------------
-- Date Check---------------Helps manipulate the date columns
SELECT
    RecordDate2,
    TO_DATE(RecordDate2) AS watch_date
FROM bright_tv_userprofile;

SELECT
    UserID0,
    RecordDate2,
    TO_DATE(RecordDate2) AS watch_date,          -- Converts a string into a date
    DAYNAME(TO_DATE(RecordDate2)) AS day_name,   -- Extracts the day name
    MONTHNAME(TO_DATE(RecordDate2)) AS month_name, -- Extracts the month name
    YEAR(TO_DATE(RecordDate2)) AS event_year,    -- Extracts the year
    DAY(TO_DATE(RecordDate2)) AS event_day       -- Extracts the day of the month
FROM bright_tv_userprofile;


SELECT
    COUNT(DISTINCT UserID0) AS number_of_subs,
    RecordDate2,
    TO_DATE(RecordDate2) AS watch_date,
    DAYNAME(TO_DATE(RecordDate2)) AS day_name,

    CASE
        WHEN DAYNAME(TO_DATE(RecordDate2)) IN ('Saturday', 'Sunday')
            THEN '02. Weekend'
        ELSE '01. Weekday'
    END AS Day_Classification,

    MONTHNAME(TO_DATE(RecordDate2)) AS month_name,
    YEAR(TO_DATE(RecordDate2)) AS event_year,
    DAY(TO_DATE(RecordDate2)) AS event_day

FROM bright_tv_viewership

WHERE UserID0 IS NOT NULL

GROUP BY
    RecordDate2,
    TO_DATE(RecordDate2),
    DAYNAME(TO_DATE(RecordDate2)),
    CASE
        WHEN DAYNAME(TO_DATE(RecordDate2)) IN ('Saturday', 'Sunday')
            THEN '02. Weekend'
        ELSE '01. Weekday'
    END,
    MONTHNAME(TO_DATE(RecordDate2)),
    YEAR(TO_DATE(RecordDate2)),
    DAY(TO_DATE(RecordDate2))

ORDER BY watch_date;
------------------------------------------------------------------------------------------------------
SELECT *
FROM`bright-tv`.brighttvdata.bright_tv_viewership;
---------------------------------------------------------------------------
---- checking if any colum is empty
-----------------------------------------------------------------------
SELECT *
FROM`bright-tv`.brighttvdata.bright_tv_viewership
WHERE USerID0 IS NULL OR
      userid4 IS NULL;
GROUP BY UserID
HAVING COUNT(*) > 1;
-------------------------------------------------------------------------

-------------------------------------------------------------------------
 
 SELECT DISTINCT Gender
 FROM bright_tv_userprofile; 

 SELECT COUNT(*)
FROM bright_tv_userprofile
WHERE gender=' ';

SELECT DISTINCT
    CASE
        WHEN Gender = 'None' THEN 'unknown'
        WHEN Gender = ' ' THEN 'unknown'
        WHEN Gender IS NULL THEN 'unknown'
        ELSE Gender
    END AS Sex
FROM bright_tv_userprofile;

SELECT DISTINCT
    CONCAT('[', Gender, ']') AS Gender_Value
FROM bright_tv_userprofile;
--------------------------------------------------
-- Checking why my first query did not apply.
-- The issue is data may have space and needs Trimming - update'.
SELECT DISTINCT Gender
FROM bright_tv_userprofile;
---------------------------------------------------
--RACE CHECK----------------------------
SELECT DISTINCT race
FROM bright_tv_userprofile;

SELECT COUNT(*) AS num_rows
FROM bright_tv_userprofile
WHERE Race IS NULL;

SELECT COUNT(DISTINCT UserID) AS subs,
       CASE
           WHEN Race = 'other' THEN 'unknown' ---  Replace other with unknown
           WHEN Race = 'None' THEN 'unknown'---  Replace None with unknown
           WHEN Race = ' ' THEN 'unknown'-----Replace empty with unknown
           WHEN Race IS NULL THEN 'unknown'-----Replace empty with unknown
           ELSE Race
       END AS ethnicity
FROM bright_tv_userprofile
GROUP BY ethnicity;
-----------------------------------------------------------------------------------------------
--- The above leaves the empty as blank and does not apply the condition, possible space in the data sheet and will need to be TRIM down - apply Trim to own project for submission
------------------------------------------------------------------------------

-- Province Check-----------------------------------
SELECT DISTINCT Province
FROM bright_tv_userprofile;

SELECT DISTINCT 
    CASE
        WHEN Province = 'None' THEN 'unknown'
        WHEN Province = ' ' THEN 'unknown' ----- The mistake of not writing code as '' and not adding space, will return all the NULLS with out the code name unknown.
        WHEN Province IS NULL THEN 'unknown'
        ELSE Province
    END AS Region
FROM bright_tv_userprofile;

-- Age Check-----------------------------------
SELECT MIN(Age) AS min_age,
       MAX(Age) AS max_age,
       AVG(Age) AS mean_age
FROM bright_tv_userprofile;

SELECT COUNT(*) AS cnt
FROM bright_tv_userprofile
WHERE age IS NULL;

SELECT
    CASE
        WHEN Age = 0 THEN 'Infant'
        WHEN Age BETWEEN 1 AND 12 THEN 'Kids'
        WHEN Age BETWEEN 13 AND 17 THEN 'Youth'
        WHEN Age BETWEEN 18 AND 35 THEN 'Young Adult'
        WHEN Age BETWEEN 36 AND 50 THEN 'Adults'
        WHEN Age > 50 AND Age <= 60 THEN 'Elder'
        ELSE 'Senior'
    END AS Age_Group
FROM bright_tv_userprofile;
------------------------------------------------------
-- Email Check-----------------------------------

SELECT
    UserID,

    CASE
        WHEN Email IS NOT NULL THEN 1
        ELSE 0
    END AS email_flag

FROM bright_tv_userprofile;
-- Contact Information Check-----------------------------------

SELECT
    UserID,

    CASE
        WHEN (Email IS NOT NULL)
             OR (Email <> '')
             OR (`Social Media Handle` NOT IN ('None', 'other'))
        THEN 1
        ELSE 0
    END AS email_flag,

    CASE
        WHEN (`Social Media Handle` IS NOT NULL)
             OR (`Social Media Handle` <> '')
             OR (`Social Media Handle` NOT IN ('None', 'other'))
        THEN 1
        ELSE 0
    END AS social_media_flag
FROM bright_tv_userprofile;
-------------------------------------------------------------------------
---Post running all the codes againg and understanding the - I decided to run the full userprofile cleaning code
------Note all NULL codes are deleted cause we are applying a fully cleaned code------

SELECT
    userid,
    CASE
        WHEN Gender = 'None' THEN 'unknown'
        WHEN Gender = ' ' THEN 'unknown'
        ELSE Gender
    END AS Sex,
    CASE
      WHEN Age = 0 THEN 'Infant'
        WHEN Age BETWEEN 1 AND 12 THEN 'Kids'
        WHEN Age BETWEEN 13 AND 17 THEN 'Youth'
        WHEN Age BETWEEN 18 AND 35 THEN 'Young Adult'
        WHEN Age BETWEEN 36 AND 50 THEN 'Adults'
        WHEN Age > 50 AND Age <= 60 THEN 'Elder'
        ELSE 'Senior'
    END AS Age_Group,

    CASE
        WHEN Province = 'None' THEN 'unknown'
        WHEN Province = ' ' THEN 'unknown' ----- The mistake of not writing code as '' and not adding space, will return all the NULLS with out the code name unknown.
        ELSE Province
    END AS Location,
    CASE
           WHEN Race = 'other' THEN 'unknown' ---  Replace other with unknown
           WHEN Race = 'None' THEN 'unknown'---  Replace None with unknown
           WHEN Race = ' ' THEN 'unknown'-----Replace empty with unknown
           WHEN Race IS NULL THEN 'unknown'-----Replace empty with unknown
           ELSE Race
       END AS ethnicity,

    CASE
        WHEN (Email IS NOT NULL)
             OR (Email <> '')
             OR (`Social Media Handle` NOT IN ('None', 'other'))
        THEN 1
        ELSE 0
    END AS email_flag,

    CASE
        WHEN (`Social Media Handle` IS NOT NULL)
             OR (`Social Media Handle` <> '')
             OR (`Social Media Handle` NOT IN ('None', 'other'))
        THEN 1
        ELSE 0
    END AS social_media_flag
FROM bright_tv_userprofile;

-----------------------------------------------------------------------
--- Data Types
----------------------------------
----- int (integer) is a number without a decimal (0787372565)
--- str(string/objects) is a combination of character (a-z, 0-9,/,>.)
----DateTime, Timestamp,-its a Date
------------------------------------------------------------------------------
-- Date Check---------------Helps manipulate the date columns
SELECT
    RecordDate2,
    TO_DATE(RecordDate2) AS watch_date
FROM bright_tv_viewership;

SELECT
    UserID0,
    RecordDate2,
    TO_DATE(RecordDate2) AS watch_date,          -- Converts a string into a date
    DAYNAME(TO_DATE(RecordDate2)) AS day_name,   -- Extracts the day name
    MONTHNAME(TO_DATE(RecordDate2)) AS month_name, -- Extracts the month name
    YEAR(TO_DATE(RecordDate2)) AS event_year,    -- Extracts the year
    DAY(TO_DATE(RecordDate2)) AS event_day       -- Extracts the day of the month
FROM bright_tv_viewership;


SELECT
    COUNT(DISTINCT UserID0) AS number_of_subs,
    RecordDate2,
    TO_DATE(RecordDate2) AS watch_date,
    DAYNAME(TO_DATE(RecordDate2)) AS day_name,

    CASE
        WHEN DAYNAME(TO_DATE(RecordDate2)) IN ('Saturday', 'Sunday')
            THEN '02. Weekend'
        ELSE '01. Weekday'
    END AS Day_Classification,

    MONTHNAME(TO_DATE(RecordDate2)) AS month_name,
    YEAR(TO_DATE(RecordDate2)) AS event_year,
    DAY(TO_DATE(RecordDate2)) AS event_day

FROM bright_tv_viewership

WHERE UserID0 IS NOT NULL

GROUP BY
    RecordDate2,
    TO_DATE(RecordDate2),
    DAYNAME(TO_DATE(RecordDate2)),
    CASE
        WHEN DAYNAME(TO_DATE(RecordDate2)) IN ('Saturday', 'Sunday')
            THEN '02. Weekend'
        ELSE '01. Weekday'
    END,
    MONTHNAME(TO_DATE(RecordDate2)),
    YEAR(TO_DATE(RecordDate2)),
    DAY(TO_DATE(RecordDate2))

ORDER BY watch_date;
------------------------------------------------------------------------------------------------------
SELECT *
FROM bright_tv_viewership;
---------------------------------------------------------------------------
---- checking if any colum is empty
-----------------------------------------------------------------------
SELECT *
FROM bright_tv_viewership
WHERE USerID0 IS NULL OR
      userid4 IS NULL;


