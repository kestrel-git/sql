with prevWeather as (
    select 
          *
        , case when (recordDate - lag(recordDate) over (order by recordDate)) = 1 
                    then lag(temperature) over (order by recordDate)
               else null
          end as prevTemperature
    from Weather
)
select id
from prevWeather
where prevTemperature is not null
  and temperature > prevTemperature
;
