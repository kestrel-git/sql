with 
	p_table as (
		select 
			page_path,
			count(*) as page_cnt
		from 
			ga.ga_sess_hits as sh
		join
			ga.ga_sess as s
			on sh.sess_id = s.sess_id
		where 
			to_date('20161101', 'yyyymmdd') - interval '30 days' <= visit_stime
			and visit_stime < to_date('20161101', 'yyyymmdd')
			and hit_type = 'PAGE'
		group by 
			page_path 	
	),
	up_table as (
		select 
			page_path,
			count(distinct sh.sess_id) as unique_page_cnt
		from 
			ga.ga_sess_hits as sh
		join
			ga.ga_sess as s
			on sh.sess_id = s.sess_id
		where 
			to_date('20161101', 'yyyymmdd') - interval '30 days' <= visit_stime
			and visit_stime < to_date('20161101', 'yyyymmdd')
			and hit_type = 'PAGE'
		group by 
			page_path
	)
select 
	p.page_path,
	page_cnt,
	unique_page_cnt
from 
	p_table as p
join
	up_table as up
	on p.page_path = up.page_path
order by 
	page_cnt desc
;
