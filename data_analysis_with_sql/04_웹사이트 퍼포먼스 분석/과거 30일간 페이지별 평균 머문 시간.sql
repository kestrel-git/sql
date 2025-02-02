-- 과거 30일간 페이지별 평균 머문 시간
-- (세션별 마지막 탈출 페이지는 평균 계산에서 제외)
with
	calc_nh as (
		select
			sh.sess_id,
			hit_seq,  -- 페이지 히트 순서
			page_path,  -- 페이지 경로
			hit_time,  -- 페이지 히트 시간
			lead(hit_time) over (partition by sh.sess_id order by hit_seq) as next_hit_time  -- 동일 세션 내 다음 페이지 히트 시간
		from
			ga.ga_sess_hits as sh
		join
			ga.ga_sess as s
			on sh.sess_id = s.sess_id 
		where 
			to_date('20161101', 'yyyymmdd') - interval '30 days' <= visit_stime  -- 과거 30일간 데이터 조회
			and visit_stime < to_date('20161101', 'yyyymmdd')
			and hit_type = 'PAGE'
	)
select 
	page_path,
	round(avg(next_hit_time - hit_time) / 1000.0, 2) as avg_elapsed_sec  -- 평균 페이지 머문 시간
from
	calc_nh
where
	next_hit_time is not null  -- 마지막 페이지여서 다음 페이지 히트 시간이 없는 경우는 제외
group by 
	page_path  -- 페이지별 그룹화
;
