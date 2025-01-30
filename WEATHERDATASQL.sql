-- SELECT ALL DATA
SELECT * FROM demo.weather_data;

-- SELECT SPECIFIC COLUMNS
SELECT timestamp_utc, temp, relative_humidity, wind_spd FROM weather_data;

-- FILTER BY TEMP
SELECT * FROM weather_data WHERE temp > 30;

-- AVG TEMP BY DAY
SELECT DATE(timestamp_utc) AS date, AVG(temp) AS avg_temp
FROM weather_data
GROUP BY DATE(timestamp_utc);

-- MAX WIND SPEED
SELECT MAX(wind_spd) AS max_wind_speed FROM weather_data;

-- FILTER BY WEATHER DESCRIPTION
SELECT * FROM weather_data WHERE description = 'Clear Sky';

-- COUNT OF WEATHER CONDITION
SELECT description, COUNT(*) AS count
FROM weather_data
GROUP BY description;

-- RANKING DAYS BY MAX TEMP
WITH daily_max_temp AS (
    SELECT 
        DATE(timestamp_utc) AS date,
        MAX(temp) AS max_temp
    FROM weather_data
    GROUP BY DATE(timestamp_utc)
)
SELECT 
    date,
    max_temp,
    RANK() OVER (ORDER BY max_temp DESC) AS temp_rank
FROM daily_max_temp;

-- DAYS WITH EXTREME WEATHER CONDITION
WITH extreme_weather AS (
    SELECT 
        DATE(timestamp_utc) AS date,
        MAX(wind_spd) AS max_wind_speed,
        MIN(vis) AS min_visibility,
        SUM(precipitation) AS total_precipitation
    FROM weather_data
    GROUP BY DATE(timestamp_utc)
)
SELECT 
    date,
    max_wind_speed,
    min_visibility,
    total_precipitation,
    CASE 
        WHEN max_wind_speed > 15 OR min_visibility < 5 OR total_precipitation > 10 THEN 'Extreme'
        ELSE 'Normal'
    END AS weather_condition
FROM extreme_weather;

-- MOST FREQUENT WEATHER DESCRIPTION
WITH weather_frequency AS (
    SELECT 
        DATE(timestamp_utc) AS date,
        description,
        COUNT(*) AS description_count
    FROM weather_data
    GROUP BY DATE(timestamp_utc), description
),
ranked_weather AS (
    SELECT 
        date,
        description,
        description_count,
        RANK() OVER (PARTITION BY date ORDER BY description_count DESC) AS rank
    FROM weather_frequency
)
SELECT 
    date,
    description,
    description_count
FROM ranked_weather
WHERE rank = 1;

-- WIND DIRECTION ANALYSIS
SELECT 
    wind_cdir_full,
    COUNT(*) AS frequency
FROM weather_data
GROUP BY wind_cdir_full
ORDER BY frequency DESC;

-- IDENTIFY DAYS WITH SUDDEN TEMP DROPS
SELECT 
    wind_cdir_full,
    COUNT(*) AS frequency
FROM weather_data
GROUP BY wind_cdir_full
ORDER BY frequency DESC;

-- TIME OF DAY WITH HIGHEST SOLAR RADIATION
SELECT 
    wind_cdir_full,
    COUNT(*) AS frequency
FROM weather_data
GROUP BY wind_cdir_full
ORDER BY frequency DESC;