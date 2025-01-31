select
	date_trunc('day', visit_stime)::date as visit_date,
	count(*) as daily_hit,  -- 일별 히트 수
	avg(count(*)) over () as avg_daily_hit  -- 평균 일별 히트 수
from
	ga.ga_sess_hits as sh
join
	ga.ga_sess as s  -- visit_stime 데이터를 가져오기 위해 
	on sh.sess_id = s.sess_id
where 
	to_date('20161101', 'yyyymmdd') - interval '30 days' <= date_trunc('day', visit_stime)
	and date_trunc('day', visit_stime) < to_date('20161101', 'yyyymmdd')  -- 현재(2016/11/01)로부터 과거 30일간 데이터 조회
	and hit_type = 'PAGE'  -- 페이지 타입만 조회
group by 
	date_trunc('day', visit_stime)::date  -- 일 단위로 그룹화 
;
