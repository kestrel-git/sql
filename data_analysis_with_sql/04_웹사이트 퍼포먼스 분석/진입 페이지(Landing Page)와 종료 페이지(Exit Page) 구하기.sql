-- 진입 페이지, 종료 페이지, 종료 페이지 여부 컬럼 구하기 (hit_type이 'PAGE'인 것만)
--   * 진입 페이지: 세션이 처음 hit한 페이지
--   * 종료 페이지: 세션이 마지막으로 hit한 페이지
select
	sess_id,  -- 세션 ID
	hit_seq,  -- hit 순서
	page_path,  -- 방문 페이지
	first_value(page_path) over (partition by sess_id order by hit_seq) as landing_page_path,  -- 진입 페이지
	last_value(page_path) over (partition by sess_id order by hit_seq 
								rows between unbounded preceding and unbounded following) as exit_page_path,  -- 종료 페이지
	case when row_number() over (partition by sess_id order by hit_seq desc) = 1
		 then true else false 
		 end as is_exit_page  -- 종료 페이지 여부
from
	ga.ga_sess_hits
where 
	hit_type = 'PAGE'  -- PAGE 타입에 한해서만 집계
;
