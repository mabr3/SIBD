--15
select week_day_name, avg(reading)
from meter_readings natural join date_dimension
group by week_day_name with ROLLUP;

--16
select week_number, avg(reading)
from meter_readings natural join date_dimension
where week_number>(
  (select max(week_number) from date_dimension)-3)
group by week_number with rollup;

--17
select building_name, week_number, avg(reading) from meter_readings natural join building_dimension natural join date_dimension
where week_number >(select max(week_number)-3 from date_dimension)
group by building_name, week_number with rollup;

--18
select building_name, avg(reading)
from meter_readings natural join building_dimension
group by building_name
order by avg(reading) desc;

--19
select building_name, day_period, avg(reading)
from meter_readings natural join building_dimension natural join time_dimension
group by building_name, day_period
order by building_name asc, avg(reading) desc;

--No. F is in the Morning.

--20

select building_name, day_period, hour_of_day, avg(reading)
from meter_readings natural join building_dimension natural join time_dimension
group by building_name, hour_of_day
order by building_name asc, avg(reading) desc;

--21
--Avg(sum(hours_Afternoon))>Avg(sum(hours_Morning)) even though there's an hour
--in the Morning with higher avg than all hours in the Afternoon.
