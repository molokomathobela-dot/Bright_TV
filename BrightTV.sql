-- Databricks notebook source
USE CATALOG `bright-tv`;
USE SCHEMA brighttvdata;

SELECT * 
FROM bright_tv_userprofile
 LIMIT 100;

 ------------------------------------------------------------------------
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
FROM bright_tv_viewership;

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
---------------------------------------------------------------------
---- checking empty space between the two userid data column--------
SELECT *
FROM bright_tv_viewership
WHERE USerID0 IS NULL;

SELECT *
FROM bright_tv_viewership
WHERE userid4 IS NULL;

---------------------------------------------------------------------------
---- checking if any colum is empty
-----------------------------------------------------------------------
SELECT *
FROM bright_tv_viewership
WHERE USerID0 IS NULL OR
      userid4 IS NULL;

-----Duplication check--------------------------
SELECT
    COUNT(*) AS cnt,
    UserID0
FROM bright_tv_viewership
GROUP BY UserID0
HAVING COUNT(*) > 1;

SELECT *
C
WHERE userid0 <> userid4;

------------------------------------------------------------------------------
------ DAta size check---------------------------------------
---- The userid0 hase 4386 rows, whilst userid4 has 4080 rows, what may cause the diffrence?

---UserID0 and UserID4 are not identical columns. Some IDs exist in UserID0 that never appear in UserID4.
---UserID4 has fewer unique values because more IDs are repeated.
---UserID4 may be a cleaned, transformed, or linked version of UserID0, depending on how the dataset was created.
-----------------------------------------------------------------------------------------------
SELECT COUNT(*) AS number_of_rows,
COUNT(DISTINCT UserID0) AS number_subs
FROM bright_tv_viewership;


SELECT COUNT(*) AS number_of_rows,
COUNT(DISTINCT UserId4) AS number_subs
FROM bright_tv_viewership;
------- we count the rows not in both columns---------------
SELECT COUNT(*) AS New_data
FROM bright_tv_viewership
WHERE UserID0 NOT IN (SELECT DISTINCT UserId4 FROM bright_tv_viewership WHERE UserId4 IS NOT NULL);
----- we found 484 data that is in userid4 but not in userid0----------
---------------------------------------------------------------------------------------------------
------- we count the unique IDs not in both columns---------------
SELECT DISTINCT UserID0
FROM bright_tv_viewership
    WHERE UserID0 IS NOT NULL AND UserID0 NOT IN (SELECT DISTINCT UserID4 FROM bright_tv_viewership WHERE UserID4 IS NOT NULL);
    ------ Unique IDs 334 -------

SELECT DISTINCT UserID4
FROM bright_tv_viewership
WHERE UserID4 IS NOT NULL AND UserID4 NOT IN (SELECT DISTINCT UserID0 FROM bright_tv_viewership WHERE UserID0 IS NOT NULL);
------- unique IDs 28 ----------------
----------------------------------------------------------------------------------------------------------------
---- possible hypothesis
-------------------------------------------------------------------------------------------------------------------
 --watched, paused, resumed
 --different ID systems
 --Data capture inconsistance/ data migrations
 --------------------------------------------------------------------------------------------------
 ---- Date Function-------------------------------------

SELECT
  COUNT(DISTINCT UserID0) AS number_of_subs,
  RecordDate2,
  TO_DATE(RecordDate2) AS watch_date,
  DAYNAME(TO_DATE(RecordDate2)) AS day_name,
  CASE
    WHEN DAYNAME(TO_DATE(RecordDate2)) IN ('Sat', 'Sun') THEN '02. Weekend'
    ELSE '01. Weekday'
  END AS Day_classification,
  MONTHNAME(TO_DATE(RecordDate2)) AS month_name,
  YEAR(TO_DATE(RecordDate2)) AS event_year
FROM bright_tv_viewership
WHERE UserID0 IS NOT NULL
GROUP BY
  RecordDate2,
  TO_DATE(RecordDate2),
  DAYNAME(TO_DATE(RecordDate2)),
  MONTHNAME(TO_DATE(RecordDate2)),
  YEAR(TO_DATE(RecordDate2)
)
ORDER BY watch_date DESC;

SELECT
    CASE
        WHEN DAYNAME(TO_DATE(RecordDate2)) IN ('Saturday', 'Sunday') THEN 'Weekend'
    ELSE 'Weekday'
END AS Day_Classification,MONTHNAME(TO_DATE(RecordDate2)) AS Month_Name
FROM bright_tv_viewership;

SELECT
date_format(RecordDate2, 'HH:mm:ss') AS watch_time,
    CASE
        WHEN watch_time BETWEEN '00:00:00' AND '05:59:59' THEN '01. Midnight'
        WHEN watch_time BETWEEN '06:00:00' AND '11:59:59' THEN '02. Morning'
        WHEN watch_time BETWEEN '12:00:00' AND '16:59:59' THEN '03. Afternoon'
        WHEN watch_time BETWEEN '17:00:00' AND '23:59:59' THEN '04. Evening'
        END AS time_of_day
FROM bright_tv_viewership;

SELECT
DATE_FORMAT(`Duration 2`, 'HH:mm:ss') AS duration,
    CASE
    WHEN duration BETWEEN '00:05:00' AND '00:30:00' THEN '01. Low Usage: <30 min'
    WHEN duration BETWEEN '00:30:01' AND '00:59:59' THEN '02. Med Usage: <60 min'
    WHEN duration > '00:59:59' THEN '03. High Usage: >60 min'
    ELSE '04. No Usage'
    END AS screen_time_bucket,
    HOUR(RecordDate2) AS hour_of_day
FROM bright_tv_viewership;
---------------------------------------------------------------------------------
------ channel watch---------
SELECT
    CASE
        WHEN Channel2 IN ('SawSee','Sawsee') THEN 'SawSee'
        WHEN Channel2 IN ('SuperSport Live Events','Live on SuperSport', 'Supersport Live Events', 'DStv Events 1') THEN 'Live Events'
        ELSE Channel2
        END AS Tv_channel
FROM bright_tv_viewership;

------ Most watched channel ---------
SELECT
Channel2,
    AVG(`Duration 2`) AS Average_Viewing_Duration
FROM bright_tv_viewership
    WHERE `Duration 2`IS NOT NULL
    GROUP BY Channel2
ORDER BY Average_Viewing_Duration DESC;

------ Viewing Duration Analysis --------------------------------------
SELECT
    AVG(Duration 2) AS Average_Viewing_Duration
    FROM bright_tv_viewership
    WHERE Duration 2 IS NOT NULL;

------ Maximum Viewing Duration ---------------------------------------
SELECT
    MAX(`Duration 2`) AS Maximum_Viewing_Duration
    FROM bright_tv_viewership
    WHERE `Duration 2` IS NOT NULL;
------ Minimum Viewing Duration ---------------------------------------
SELECT
    MIN(`Duration 2`)  AS Minimum_Viewing_Duration
    FROM bright_tv_viewership
    WHERE `Duration 2` IS NOT NULL;
------ Total Viewing Duration -----------------------------------------
SELECT
    SUM(`Duration 2`) AS Total_Viewing_Duration
    FROM bright_tv_viewership
    WHERE`Duration 2` IS NOT NULL;
------ Unique Viewers per Channel -------------------------------------
SELECT
Channel2,
    COUNT(DISTINCT UserID0) AS Unique_Viewers
    FROM bright_tv_viewership
    WHERE UserID0 IS NOT NULL
    GROUP BY Channel2
    ORDER BY Unique_Viewers DESC;


