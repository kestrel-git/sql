select
	page_path,
	count(*) as hit_count
from
	ga.ga_sess_hits
group by
	page_path
order by 
	hit_count desc
limit 5
;
