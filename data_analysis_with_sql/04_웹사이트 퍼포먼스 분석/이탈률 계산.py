-- 이탈률(Bounce Rate)
--  * 최초 접속 후 다른 페이지로 이동하지 않고 바로 종료한 세션 비율
with
	hit_cnt_per_sess as (
		select
			sess_id,
			count(*) as hit_cnt  -- 세션별 hit 개수 계산 
		from
			ga.ga_sess_hits
		group by
			sess_id  -- 세션별 그룹
	)
select 
	sum(case when hit_cnt = 1 then 1 else 0 end) as bounce_sess,  -- hit가 1인 세션 개수 계산
	count(*) as total_sess,  -- 전체 세션 개수
	round(100.0 * sum(case when hit_cnt = 1 then 1 else 0 end) / count(*), 2) as bounce_rate
from
	hit_cnt_per_sess
;
