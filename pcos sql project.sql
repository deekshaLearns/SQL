-- RETRIEVE ALL DATA
SELECT * FROM demo.cleaneddata ;

-- SELECT AGE WEIGHT HEIGHT COULUMNS
SELECT Age, Weight_kg, Height_ft, PCOS FROM demo.cleaneddata ;

-- FILTER BY CONDITION 
SELECT * FROM demo.cleaneddata WHERE PCOS = 'YES' ;
SELECT * FROM demo.cleaneddata WHERE Family_History_PCOS = 'YES' ;

-- COUNT THE NUMBER OF INDIVIDUALS IN EACH GROUP:
SELECT Age, COUNT(*) AS Count FROM demo.cleaneddata GROUP BY Age; 

-- AVERAGE WEIGHT OF INDIVIDUALS BASED ON PCOS STATUS:
SELECT PCOS, AVG(Weight_kg) AS Avg_Weight FROM demo.cleaneddata GROUP BY PCOS;

-- DISTRIBUTION OF EXERCISE FREQUENCY 
SELECT Exercise_Frequency, Count(*) AS COUNT FROM demo.cleaneddata GROUP BY Exercise_Frequency;

-- JOIN EXERCISE AND DIET DATA
SELECT d.Age, d.Exercise_Frequency, d.Diet_Fruits, d.Diet_Sweets FROM demo.cleaneddata AS d WHERE d.Exercise_Frequency = 'Daily' ;

-- INDIVIDUAL WITH IRREGULAR MENSTRUATION AND HORMONAL IMBALANCE
SELECT * FROM demo.cleaneddata WHERE Menstrual_Irregularity = 'YES' AND Hormonal_Imbalance = 'YES' ;

-- FILTER INDIVIDUAL WITH MORE THAN 6 HOURS OF SLEEP AND LOW STRESS
SELECT * FROM demo.cleaneddata
WHERE SLEEP_HOURS = '6-8 HOURS'
AND STRESS_LEVEL = 'NO' ;

-- CHECK FOR PCOS MEDICATION USAGE AMONG THOSE WITH PCOS
SELECT PCOS, PCOS_Medication,
COUNT(*) AS Count
FROM demo.cleaneddata
WHERE PCOS = 'YES'
GROUP BY PCOS, PCOS_Medication ;





































