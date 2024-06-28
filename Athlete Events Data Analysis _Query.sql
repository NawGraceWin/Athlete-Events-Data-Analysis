
   Project _ Athlete Events Data Analysis _ Answers

1 . How many olympics games have been held?

Select COUNT( DISTINCT games) from Athlete_events


2 . List down all Olympics games held so far.

    Select DISTINCT games from Athlete_events


3.  list down all olympics in year-season-city format.

 
	select distinct(cast(year as varchar) +'-'+season+'-'+city) from Athlete_events


4.  Mention the total no of nations who participated in each olympics game?

Select COUNT(distinct team) as no_of_nations, games from Athlete_events group by games order by games


5 . Which year saw the highest and lowest no of countries participating in olympics?

with a as (
select  year,noc  from Athlete_events 
group by year,noc
),
b as (
select count(noc) c,year from a group by year)
select year, c from b 
where c in ((select Max(c) from b),(select Min(c) from b))


6 . Which nation has participated in all of the olympic games?

with a as 
(select Team,games from Athlete_events group by Team,games
)
select Team,count(games)from a group by Team
having count(games)= (select count(distinct games) from Athlete_events)



7 . Identify the sport which was played in all summer olympics.


with c as(
select sport,games from Athlete_events
group by sport,games)
select sport,count(games) from c
group by sport
having count(sport)=
(select count(distinct games) from Athlete_events where season = 'summer')




8 . Which Sports were just played only once in the olympics?

with a as 
(select sport,games from Athlete_events 
group by sport,games
)
select sport,count(games)from a
group by sport
having count(sport)= 1


9. Fetch the total no of sports played in each olympic games.

with c as (
select  games ,sport from Athlete_events
group by games,sport)
select games,count(sport) b from c
group by games
order by b desc


10 . Fetch details of the oldest athletes to win a gold medal.

with c as  (
select * from Athlete_events where medal = 'gold' 
),
b as (
select id,name,sex,cast(age as int) a,height,weight,team,noc,games,year,city,sport,event,medal from c)
select * from b
where a = (select max(a) from b)



11 . Find the Ratio of male and female athletes participated in all olympic games.

with a as (
select distinct [name],sex from Athlete_events
)
select 
try_convert(float,(select count(name) n1  from a where sex = 'f'
))/try_convert(float,(
select count(name) n2 from a where sex = 'm'
))


12 . Fetch the top 5 athletes who have won the most gold medals.

with a as (
select id,name,count(medal) as c from Athlete_events where medal = 'gold'
group by id,[name]
) 
select name,c from a where c in (select distinct top 5 c from a order by c desc)
order by c desc



13 . Fetch the top 5 athletes who have won the most medals (gold/silver/bronze).

with a as (
select id,name,count(medal) as c from Athlete_events where medal != 'NA'
group by id,[name]
) 
select name,c from a where c in (select distinct top 5 c from a order by c desc)
order by c desc




14 . Fetch the top 5 most successful countries in olympics. Success is defined by no of medals won.



select TOP 5( NOC) ,count(medal) from Athlete_events where medal!= 'NA'
group by NOC order by count(Medal) desc



15 . List down total gold, silver and broze medals won by each country.

select noc , gold,silver,bronze from(
select noc,medal,count(id) c from Athlete_events
where medal != 'NA'
group by noc,medal) as m
pivot(sum(c) for medal in(gold,silver,bronze)) as pt
order by gold desc