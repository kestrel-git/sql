select 
	to_char(date_trunc('day', visit_stime), 'yyyy-mm-dd') as visit_date,
	count(sess_id) as daily_sess_cnt,  -- 일별 세션 수
	count(distinct user_id) as daily_user_cnt,  -- 일별 방문 사용자 수
	1.0 * count(sess_id) / count(distinct user_id) as daily_sess_cnt_per_user  -- 일별 사용자당 세션 수
from 
	ga.ga_sess
group by
	to_char(date_trunc('day', visit_stime), 'yyyy-mm-dd')
;
