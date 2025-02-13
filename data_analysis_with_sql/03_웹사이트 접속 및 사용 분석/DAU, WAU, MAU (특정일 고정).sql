----------------------------------------------------
-- 특정일(2016년 11월 1일)을 기준으로 DAU, WAU, MAU 계산 --
----------------------------------------------------

-- 1. DAU
select 
	count(distinct user_id) as dau
from 
	ga.ga_sess 
where 
	to_date('2016-11-01', 'yyyy-mm-dd') - interval '1 day' <= visit_stime 
	and visit_stime < to_date('2016-11-01', 'yyyy-mm-dd');



-- 2. WAU
select 
	count(distinct user_id) as wau
from
	ga.ga_sess
where 
	to_date('2016-11-01', 'yyyy-mm-dd') - interval '7 days' <= visit_stime 
	and visit_stime < to_date('2016-11-01', 'yyyy-mm-dd');



-- 3. MAU
select 
	count(distinct user_id) as mau
from 
	ga.ga_sess gs 
where 
	to_date('2016-11-01', 'yyyy-mm-dd') - interval '30 days' <= visit_stime 
	and visit_stime < to_date('2016-11-01', 'yyyy-mm-dd')


	
-- 4. 한 테이블에 DAU, WAU, MAU 표시

-- 4.1. 기존 테이블 삭제
drop table if exists active_users;  

-- 4.2. 테이블 생성
create table if not exists active_users (
	d_day date,
	dau integer,
	wau integer,
	mau integer
);

-- 4.3. 테이블에 DAU, WAU, MAU 값 추가
insert into active_users  
select
	to_date('2016-11-01', 'yyyy-mm-dd'),  -- 기준 날짜
	(  -- DAU
		select 
			count(distinct user_id)
		from
			ga.ga_sess 
		where
			to_date('2016-11-01', 'yyyy-mm-dd') - interval '1 day' <= visit_stime
			and visit_stime < to_date('2016-11-01', 'yyyy-mm-dd')
	),
	(  -- WAU
		select 
			count(distinct user_id)
		from
			ga.ga_sess 
		where
			to_date('2016-11-01', 'yyyy-mm-dd') - interval '7 days' <= visit_stime
			and visit_stime < to_date('2016-11-01', 'yyyy-mm-dd')
	),
	(  -- MAU
		select 
			count(distinct user_id)
		from
			ga.ga_sess 
		where
			to_date('2016-11-01', 'yyyy-mm-dd') - interval '30 days' <= visit_stime
			and visit_stime < to_date('2016-11-01', 'yyyy-mm-dd')
	)
;

-- 4.4. 결과 확인
select * from active_users;
