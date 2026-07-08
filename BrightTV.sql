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
--RACE CHECK
SELECT DISTINCT race
FROM bright_tv_userprofile;

SELECT COUNT(DISTINCT UserID) AS subs,
       CASE
           WHEN Race = 'other' THEN 'unknown'
           WHEN Race = 'None' THEN 'unknown'
           WHEN Race = '' THEN 'unknown'
           WHEN Race IS NULL THEN 'unknown'
           ELSE Race
       END AS ethnicity
FROM bright_tv_userprofile
GROUP BY ethnicity;



