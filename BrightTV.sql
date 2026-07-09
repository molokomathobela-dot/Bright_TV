-- Databricks notebook source
USE CATALOG `bright-tv`;
USE SCHEMA brighttvdata;

SELECT *
FROM bright_tv_userprofile
 LIMIT 100;
 
 SELECT DISTINCT Gender
 FROM bright_tv_userprofile; 

SELECT DISTINCT
    CASE
        WHEN Gender = 'None' THEN 'unknown'
        WHEN Gender = '' THEN 'unknown'
        WHEN Gender IS NULL THEN 'unknown'
        ELSE Gender
    END AS Sex
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

SELECT COUNT(DISTINCT UserID) AS subs,
       CASE
           WHEN Race = 'other' THEN 'unknown' ---  Replace other with unknown
           WHEN Race = 'None' THEN 'unknown'---  Replace None with unknown
           WHEN Race = '' THEN 'unknown'-----Replace empty with unknown
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
FROM`bright-tv`.brighttvdata.bright_tv_userprofile;

SELECT DISTINCT 
    CASE
        WHEN Province = 'None' THEN 'unknown'
        WHEN Province = '' THEN 'unknown'
        WHEN Province IS NULL THEN 'unknown'
        ELSE Province
    END AS Region
FROM`bright-tv`.brighttvdata.bright_tv_userprofile;

-- Age Check-----------------------------------
SELECT MIN(Age) AS min_age,
       MAX(Age) AS max_age,
       AVG(Age) AS mean_age
FROM`bright-tv`.brighttvdata.bright_tv_userprofile;


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
FROM`bright-tv`.brighttvdata.bright_tv_userprofile;
------------------------------------------------------
-- Email Check-----------------------------------

SELECT
    UserID,

    CASE
        WHEN Email IS NOT NULL THEN 1
        ELSE 0
    END AS email_flag

FROM `bright-tv`.brighttvdata.bright_tv_userprofile;
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
FROM `bright-tv`.brighttvdata.bright_tv_userprofile;
-------------------------------------------------------------------------
-- Duplication Check-----------------------------------

SELECT
    COUNT(*) AS cnt,
    UserID
FROM `bright-tv`.brighttvdata.bright_tv_userprofile
GROUP BY UserID
HAVING COUNT(*) > 1;

