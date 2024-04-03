SELECT * FROM project.sleep_health_and_lifestyle_dataset;
-- 1) What is the average Age of the participants?
select avg(Age) from sleep_health_and_lifestyle_dataset;

-- 2) How many different Occupations are represented in the dataset?
select count(distinct(Occupation)) num_of_different_occupation from sleep_health_and_lifestyle_dataset;

-- 3) What is the maximum Sleep Duration reported by the participants?
select max(`Sleep Duration`) from sleep_health_and_lifestyle_dataset;

-- 4) 	Add a column sleep_quality and find how many participants have reported Good Quality of Sleep and How many Poor Quality of Sleep?
alter table sleep_health_and_lifestyle_dataset add column sleep_quality varchar(255);
update sleep_health_and_lifestyle_dataset
set sleep_quality=
(case
when `Quality of Sleep`  between 8 and 10 then 'Good'
when `Quality of Sleep`between 5 and 7 then 'Average'
else 'Poor' end);
COMMIT;
select count(*) count from sleep_health_and_lifestyle_dataset
where sleep_quality not in ('Average');

-- 5) How many participants have reported having a Sleep Disorder?
select count(`Sleep Disorder`) total from sleep_health_and_lifestyle_dataset
where `Sleep Disorder` not in ('None');
-- 6) Update the  value of BMI Category column 'Normal weight' to  'Normal'.
update sleep_health_and_lifestyle_dataset
set `BMI Category` ='Normal'
where `BMI Category` = 'Normal Weight';
commit;
-- 7) How does the average Heart Rate vary with BMI Category?
select `BMI Category`, avg(`Heart Rate`) avg_heart_rate from sleep_health_and_lifestyle_dataset
group by `BMI Category`;
-- 8)What is the average Stress Level reported by the participants?
 select avg(`Stress Level`) as avg_stress_level from sleep_health_and_lifestyle_dataset;
 
-- 9) What is the range of Blood Pressure values recorded in the dataset?
select MIN(`Blood Pressure`) as min_blood_pressure, MAX(`Blood Pressure`) as max_blood_pressure
from sleep_health_and_lifestyle_dataset;

-- 10) What is the average Sleep Duration for each Gender?
select Gender ,avg(`Sleep Duration`) avg_sleep_duration from sleep_health_and_lifestyle_dataset;
-- 11) How does the Physical Activity Level vary with different Age Group?
select 
    case
        when Age between 20 and 30 then '20-30'
        when Age between 31 and 40 then '31-40'
        when Age between 41 and 50 then '41-50'
        when Age between 51 and 60 then '51-60'
        else 'Over 60'
    end AS age_group, 
    avg(`Physical Activity Level`) AS avg_Physical_Activity_Level
from sleep_health_and_lifestyle_dataset
group by age_group;
-- 12) How many participants have a BMI Category of 'Obese' and a Daily Steps count greater than 10000?
select count(*) count from sleep_health_and_lifestyle_dataset
where `BMI Category` = 'Obese' and 	`Daily Steps`> 10000;
-- 13) How many participants have a Sleep Disorder and a Stress Level above 5?
select  count(*) count from sleep_health_and_lifestyle_dataset
where `Sleep Disorder` not in('None') and `Stress Level` > 5;
-- 14) What is the highest average Sleep Duration for each gender where the Age is above 30?
select age,avg(`Sleep Duration`) avg_sleep_duration,Gender from sleep_health_and_lifestyle_dataset
where age > 30
group by Gender,age
order by avg_sleep_duration desc limit 1;

-- 15)What is the average Sleep Duration of participants who have a Stress Level greater than the average Stress Level?
select avg(`Sleep Duration`) as Avg_Sleep_Duration from sleep_health_and_lifestyle_dataset
where `Stress Level` > (select avg(`Stress Level`) from sleep_health_and_lifestyle_dataset);

-- 16) How many participants have a Sleep quality equal to 'Poor' and a Sleep Duration less than the average Sleep Duration?
select count(*) total from sleep_health_and_lifestyle_dataset
where `Sleep Duration`< (select avg(`Sleep Duration`) from sleep_health_and_lifestyle_dataset) and sleep_quality = 'Poor';

-- 17)What is the Blood Pressure of the participant with Person ID = 100?
select `Blood Pressure` from sleep_health_and_lifestyle_dataset
where `Person ID`= 100;
-- 18) which occupation's average daily setps is more than 5000?
select Occupation, avg(`Daily Steps`) avg_daily_steps from sleep_health_and_lifestyle_dataset
group by Occupation
having avg_daily_steps >5000
order by avg_daily_steps desc ;

-- 19) What is the average Heart Rate for participants with a BMI Category of 'Overweight' and a Sleep Disorder?
select avg(`Heart Rate`) avg_heart_rate from sleep_health_and_lifestyle_dataset
where  `Sleep Disorder` not in ('None')  and `BMI Category` = 'Overweight';

-- 20) How many participants have a  sleep_quality equal to 'Good' and a Heart Rate greater than 
-- the average Heart Rate for participants with a sleep_quality equal to 'Good'?
select count(*) from sleep_health_and_lifestyle_dataset
where sleep_quality = 'Good' and `Heart Rate` > (select avg(`Heart Rate`)from sleep_health_and_lifestyle_dataset where sleep_quality = 'Good') 










































