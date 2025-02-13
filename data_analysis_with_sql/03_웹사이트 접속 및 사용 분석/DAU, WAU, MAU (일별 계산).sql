-------------------------------------------------
-- 날짜별 DAU, WAU, MAU 계산 		       --
--   * 대상 기간: 2016년 8월 2일부터 11월 1일까지     --	
--   * DAU: 각 날짜별 지난 1일간의 Active User 계산  --
--   * WAU: 각 날짜별 지난 7일간의 Active User 계산  --
--   * MAU: 각 날짜별 지난 30일간의 Active User 계산 --
-------------------------------------------------

-- 1. DAU
drop table if exists daily_dau;		-- daily_dau 테이블이 이미 존재할 경우 삭제

create table daily_dau as		-- daily_dau 테이블 생성
with
	period_tbl as (  		-- 2016년 8월 2일부터 11월 1일까지 모든 일자 데이터 생성
		select generate_series('2016-08-02'::date, '2016-11-01'::date, '1 day'::interval)::date as dt
	)
select
	p.dt,	   			-- 기준 날짜
	count(distinct user_id) as dau  -- 기준 날짜별 DAU 계산
from
	ga.ga_sess as s
cross join  				-- ga_sess 각 행에 대해 대상 기간 날짜 전체를 갖도록 크로스 조인
	period_tbl as p
where  					-- 지난 1일간 기록된 세션 데이터만 필터링
	p.dt - interval '1 day' <= s.visit_stime 
	and s.visit_stime < p.dt 
group by
	p.dt;				-- 기준 날짜별 그룹화



-- 2. WAU
drop table if exists daily_wau;

create table daily_wau as
with
	period_tbl as (
		select generate_series('2016-08-02'::date, '2016-11-01'::date, '1 day'::interval)::date as dt
	)
select
	p.dt,
	count(distinct s.user_id) as wau
from
	ga.ga_sess as s
cross join
	period_tbl as p
where
	p.dt - interval '7 days' <= s.visit_stime
	and s.visit_stime < p.dt
group by
	p.dt;



-- 3. MAU
drop table if exists daily_mau;

create table daily_mau as
with
	period_tbl as (
		select generate_series('2016-08-02'::date, '2016-11-01'::date, '1 day'::interval)::date as dt
	)
select
	p.dt,
	count(distinct s.user_id) as mau
from
	ga.ga_sess as s
cross join
	period_tbl as p
where
	p.dt - interval '30 days' <= s.visit_stime
	and s.visit_stime < p.dt
group by
	p.dt;
	


-- 4. 한 테이블에 DAU, WAU, MAU 표시
drop table if exists daily_acquisitions;

create table daily_acquisitions as
select
	d.dt, dau, wau, mau
from
	daily_dau as d
join
	daily_wau as w on d.dt = w.dt
join
	daily_mau as m on d.dt = m.dt;

select
	*
from 
	daily_acquisitions;

