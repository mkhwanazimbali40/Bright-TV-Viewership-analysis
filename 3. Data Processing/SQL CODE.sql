SELECT 
u.UserID AS user_id,
u.Name As first_name,
u.Surname AS last_name,
u.Email,
u.Gender,
u.Race,
u.Age,
u.Province,
u.`Social Media Handle` AS social_media_handle,

v.userid AS view_user_id,
v.Channel2 AS channel,
v.Recorddate2 AS record_date,
v.`Duration 2` AS duration

FROM user_profiles u 
FULL OUTER JOIN viewer_ship v
ON u.UserID = v.UserID;
-------------------------------------------------
---------------Table - user_profiles-------------
-------------------------------------------------
---------------Check for null value--------------
-------------------------------------------------
SELECT  
     --- UserID AS user_id,
      NULLIF(Name, 'None') AS first_name,
      NULLIF(Surname, 'None') AS last_name,
      NULLIF(Email, 'None') AS email,
      NULLIF(Gender, 'None') AS gender,
      NULLIF(Race, 'None') AS race,
      ----Age AS age,
      NULLIF(Province, 'None') AS province,
      NULLIF(`Social Media Handle`, 'None') AS social_media_handle
      FROM user_profiles;

SELECT
      COUNT(*) AS total_users,
      COUNT(UserID) AS user_id_not_null,
      COUNT(Name) AS name_not_null,
      COUNT(Surname) AS surname_not_null,
      COUNT(Email) AS email_not_null,
      COUNT(Gender) AS gender_not_null,
      COUNT(Race) AS race_not_null,
      COUNT(Age) AS age_not_null,
      COUNT(Province) AS province_not_null,
      COUNT(`Social Media Handle`) AS social_media_handle_not_null
      FROM user_profiles;
-----------------------------------------------
-----------GENDER DISTRIBUTION-----------------
-----------------------------------------------
SELECT 
      Gender,
      COUNT(*) AS total_users
FROM user_profiles 
GROUP BY Gender;
-----------------------------------------------
----------------AGE DISTRIBUTION---------------
-----------------------------------------------
SELECT
      Age,
      COUNT(*) AS total_users
FROM user_profiles 
GROUP BY Age
ORDER BY Age;
-----------------------------------------------
--------------------AGE GROUPS-----------------
-----------------------------------------------
SELECT
   CASE
      WHEN Age < 30 THEN 'Young'
      WHEN Age BETWEEN 30 AND 50 THEN 'Middle'
      ELSE 'Older'
    END AS age_group,
    COUNT(*) AS total_users
FROM user_profiles
GROUP BY 
      CASE
          WHEN Age < 30 THEN 'Young'
           WHEN Age BETWEEN 30 AND 50 THEN 'Middle'
      ELSE 'Older'
    END;
-------------------------------------------------
----------------USERS BY PROVINCE----------------
-------------------------------------------------
SELECT
      Province,
      COUNT(*) AS total_users
FROM user_profiles 
GROUP BY Province
ORDER BY total_users DESC;
-------------------------------------------------
-------------DUPLICATE USERS CHECK---------------
-------------------------------------------------
SELECT
      UserID,
      COUNT(*) AS count_users
FROM user_profiles 
GROUP BY UserID
HAVING COUNT(*) > 1;
-------------------------------------------------
--------------TABLE-VIEWERSHIP-----------------
-------------------------------------------------
---------------CHECK NULL VALUES-----------------
SELECT 
      NULLIF(Channel2, 'None') AS channel,
      NULLIF(Recorddate2, 'None') AS record_date
      FROM viewer_ship;
-------------------------------------------------
--------------MOST WATCHED CHANNELS--------------
-------------------------------------------------
SELECT
      Channel2,
      COUNT(*) AS total_views
      FROM viewer_ship
      GROUP BY Channel2
      ORDER BY total_views DESC;
-------------------------------------------------
-----------TOTAL WATCH TIME PER CHANNEL----------
-------------------------------------------------
SELECT
      Channel2 AS channel,
      CONCAT(
        FLOOR(SUM(HOUR(`Duration 2`) * 3600 + MINUTE(`Duration 2`) * 60 + SECOND(`Duration 2`)) / 3600), ':',
        LPAD(FLOOR((SUM(HOUR(`Duration 2`) * 3600 + MINUTE(`Duration 2`) * 60 + SECOND(`Duration 2`)) % 3600) / 60), 2, '0'), ':',
        LPAD(SUM(HOUR(`Duration 2`) * 3600 + MINUTE(`Duration 2`) * 60 + SECOND(`Duration 2`)) % 60, 2, '0')
      ) AS total_watch_time
      FROM viewer_ship
      GROUP BY Channel2
      ORDER BY SUM(HOUR(`Duration 2`) * 3600 + MINUTE(`Duration 2`) * 60 + SECOND(`Duration 2`)) DESC;
-------------------------------------------------
------------VIEWING ACTIVITY OVER TIME-----------
-------------------------------------------------
SELECT
      DATE(from_utc_timestamp(to_timestamp(RecordDate2, 'M/d/yyyy H:mm'), 'Africa/Johannesburg')) AS view_date,
      COUNT(*) AS total_sessions
      FROM viewer_ship
      GROUP BY 
      DATE(from_utc_timestamp(to_timestamp(RecordDate2, 'M/d/yyyy H:mm'), 'Africa/Johannesburg'))
      ORDER BY view_date ASC;
-------------------------------------------------
--------------LOW CONSUMPTION DAYS---------------
-------------------------------------------------
SELECT
      DATE(from_utc_timestamp(to_timestamp(RecordDate2, 'M/d/yyyy H:mm'), 'Africa/Johannesburg')) AS view_date,
      COUNT(*) AS total_sessions
      FROM viewer_ship
      GROUP BY 
      DATE(from_utc_timestamp(to_timestamp(RecordDate2, 'M/d/yyyy H:mm'), 'Africa/Johannesburg'))
      ORDER BY total_sessions ASC;
-------------------------------------------------
-----------------MOST ACTIVE USERS---------------
-------------------------------------------------
SELECT
      userid,
      COUNT(*) AS total_sessions
FROM viewer_ship
GROUP BY UserID
ORDER BY total_sessions DESC;
-------------------------------------------------
------------CHECK FOR MISSING USERS--------------
-------------------------------------------------
SELECT *
FROM viewer_ship
WHERE UserID IS NULL;
-------------------------------------------------
-------------CHECK DUPLICATE RECORDS-------------
-------------------------------------------------
SELECT
      userid,
      Channel2,
      RecordDate2,
      COUNT(*) AS duplicate_count
FROM viewer_ship
GROUP BY userid, Channel2, RecordDate2
HAVING COUNT(*) > 1;

-----------------------------------------------------------------------
-------------------------------------------------
------------------USER ENGAGEMENT----------------
-------------------------------------------------
SELECT 
      u.UserID,
      u.Name,
      COUNT(v.Channel2) AS total_sessions
FROM user_profiles u
LEFT JOIN viewer_ship v
ON u.UserID = v.UserID
GROUP BY u.UserID, u.Name
ORDER BY total_sessions DESC;
--------------------------------------------------
-----------TOTAL WATCH TIME PER CHANNEL-----------
--------------------------------------------------
SELECT      
      Channel2 AS channel,

      CONCAT(
            FLOOR(total_seconds / 3600), ':',
            LPAD(FLOOR((total_seconds % 3600) / 60), 2, '0'), ':',
            LPAD(total_seconds % 60, 2, '0')
      ) AS total_watch_time
      FROM (
            SELECT
                  Channel2,
                  SUM(
                        HOUR(`Duration 2`) * 3600 + 
                        MINUTE(`Duration 2`) * 60 + 
                        SECOND(`Duration 2`)
                  ) AS total_seconds
                  FROM viewer_ship
                  GROUP BY Channel2
      ) t
ORDER BY total_seconds DESC;
--------------------------------------------------
------------VIEWING ACTIVITY OVER TIME------------
--------------------------------------------------
SELECT
      DATE(from_utc_timestamp(to_timestamp(RecordDate2, 'M/d/yyyy H:mm'), 'Africa/Johannesburg')) AS view_date,
      COUNT(*) AS total_sessions
      FROM viewer_ship
      GROUP BY 
      DATE(from_utc_timestamp(to_timestamp(RecordDate2, 'M/d/yyyy H:mm'), 'Africa/Johannesburg'))
      ORDER BY view_date;
--------------------------------------------------
---------------LOW CONSUMPTION DAYS---------------
--------------------------------------------------
SELECT
      DATE(from_utc_timestamp(to_timestamp(RecordDate2, 'M/d/yyyy H:mm'), 'Africa/Johannesburg')) AS view_date,
      COUNT(*) AS total_sessions
      FROM viewer_ship
      GROUP BY 
      DATE(from_utc_timestamp(to_timestamp(RecordDate2, 'M/d/yyyy H:mm'), 'Africa/Johannesburg'))
      ORDER BY total_sessions ASC
      LIMIT 5;
--------------------------------------------------
---------------CONSUMPTION BY GENDER--------------
--------------------------------------------------
SELECT
      CASE 
          WHEN u.Gender = 'None' OR  u.Gender IS NULL THEN 'Unkown'
          ELSE u.Gender
      END AS gender,
      COUNT(v.Channel2) AS total_views
      FROM user_profiles u
      LEFT JOIN viewer_ship v
      ON u.UserID = v.UserID
      GROUP BY 
            CASE 
                  WHEN u.Gender = 'None' Or u.Gender IS NULL THEN 'Unkown'
                  ELSE u.Gender
            END;
-------------------------------------------------
------------CONSUMPTION BY AGE GROUP-------------
-------------------------------------------------
SELECT
      CASE 
            WHEN u.Age < 30 THEN 'Young'
            WHEN u.Age BETWEEN 30 AND 50 THEN 'Middle'
            ELSE 'Older'
      END AS age_group,
      COUNT(v.Channel2) AS total_views
      FROM user_profiles u
      LEFT JOIN viewer_ship v
      ON u.UserID = v.UserID
      GROUP BY 
            CASE 
                  WHEN u.Age < 30 THEN 'Young'
                  WHEN u.Age BETWEEN 30 AND 50 THEN 'Middle'
            ELSE 'Older'
      END;
-------------------------------------------------
------------CONSUMPTION BY PROVINCE--------------
-------------------------------------------------
SELECT
      CASE 
            WHEN u.Province = 'None' OR u.Province IS NULL THEN 'Unkown'
            ELSE u.Province
      END AS province,
      COUNT(v.Channel2) AS total_views
      FROM user_profiles u
      LEFT JOIN viewer_ship v
      ON u.UserID = v.UserID
      GROUP BY 
            CASE 
                  WHEN u.Province = 'None' OR u.Province IS NULL THEN 'Unkown'
            ELSE u.Province
      END
ORDER BY total_views DESC;
---------------------------------------------
--------CONTENT PREFERENCE BY GENDER---------
---------------------------------------------
SELECT
      CASE 
            WHEN u.Gender = 'None' OR u.Gender IS NULL THEN 'Unkown'
            ELSE u.Gender
      END gender,
      v.Channel2,
      COUNT(*) AS total_views
      FROM user_profiles u
      INNER JOIN viewer_ship v
      ON u.UserID = v.UserID
      GROUP BY gender, v.Channel2
            ORDER BY total_views DESC;
---------------------------------------------
----------------INACTIVE USERS---------------
---------------------------------------------
SELECT 
      u.UserID,
      u.Name,
      u.Province
FROM user_profiles u
LEFT JOIN viewer_ship v 
ON u.UserID = v.UserID
WHERE v.UserID IS Null;
---------------------------------------------------------------------
SELECT
      ----USER INFO
      u.UserID,

      CASE 
            WHEN u.Gender = 'None' OR u.Gender IS NULL THEN 'Unkown'
            ELSE u.Gender
      END AS gender,
      CASE 
            WHEN u.Age < 30 THEN 'Young'
            WHEN u.Age BETWEEN 30 AND 50 THEN 'Middle'
            ELSE 'Older'
      END AS age_group,
      CASE 
            WHEN u.Province = 'None' OR u.Province IS NULL THEN 'Unkown'
            ELSE u.Province
      END AS province,

      ----VIEWING INFO
      v.Channel2 AS channel,
      
      -----DATE and TIME BREAKDOWN
      DATE(from_utc_timestamp(to_timestamp(v.RecordDate2, 'M/d/yyyy H:mm'), 'Africa/Johannesburg')) AS view_date,
      date_format(from_utc_timestamp(to_timestamp(v.RecordDate2, 'M/d/yyyy H:mm'), 'Africa/Johannesburg'), 'HH:mm:ss') AS view_time,
      HOUR(from_utc_timestamp(to_timestamp(v.RecordDate2, 'M/d/yyyy H:mm'), 'Africa/Johannesburg')) AS hour_of_day,
      MONTH(from_utc_timestamp(to_timestamp(v.RecordDate2, 'M/d/yyyy H:mm'), 'Africa/Johannesburg')) AS month,
      DAY(from_utc_timestamp(to_timestamp(v.RecordDate2, 'M/d/yyyy H:mm'), 'Africa/Johannesburg')) AS day_of_month,

      ----------DAY CLASSIFICATION
      CASE 
            WHEN dayofweek(from_utc_timestamp(to_timestamp(v.RecordDate2, 'M/d/yyyy H:mm'), 'Africa/Johannesburg')) IN (1,7)
            THEN 'Weekend'
            ELSE 'Weekday'
            END AS day_type,

      ------------time buckets
      CASE 
            WHEN HOUR(from_utc_timestamp(to_timestamp(v.RecordDate2, 'M/d/yyyy H:mm'), 'Africa/Johannesburg')) BETWEEN 6 AND 11 THEN 'Morning'
            WHEN HOUR(from_utc_timestamp(to_timestamp(v.RecordDate2, 'M/d/yyyy H:mm'), 'Africa/Johannesburg')) BETWEEN 12 AND 17 THEN 'Afternoon'
            WHEN HOUR(from_utc_timestamp(to_timestamp(v.RecordDate2, 'M/d/yyyy H:mm'), 'Africa/Johannesburg')) BETWEEN 18 AND 22 THEN 'Evening'
            ELSE 'Night'
            END AS time_bucket,

      ---------DURATION
      (
            HOUR(v.`Duration 2`) * 3600 +
            MINUTE(v.`Duration 2`) * 60 +
            SECOND(v.`Duration 2`)
      ) AS duration_seconds

      FROM user_profiles u
      LEFT JOIN viewer_ship v 
      ON u.UserID = v.UserID;
