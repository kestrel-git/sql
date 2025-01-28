with
	hits_per_sess as (
		select 
			sess_id,
			count(*) as hit_count
		from 
			ga.ga_sess_hits
		group by
			sess_id	
	)
select 
	min(hit_count) as min,
	max(hit_count) as max,
	avg(hit_count) as avg,
	percentile_disc(0.25) within group (order by hit_count) as percentile_25,
	percentile_disc(0.50) within group (order by hit_count) as percentile_50,
	percentile_disc(0.75) within group (order by hit_count) as percentile_75,
	percentile_disc(0.80) within group (order by hit_count) as percentile_80,
	percentile_disc(0.90) within group (order by hit_count) as percentile_90,
	percentile_disc(1.0) within group (order by hit_count) as percentile_100
from 
	hits_per_sess
;
