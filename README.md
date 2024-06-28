## Analyzing Athlete Performance in Athlete Events

### Project Title:
Analyzing Athlete Performance in Athlete Events Using SQL

### Objectives:
Analyze athlete performance data to identify trends and provide actionable insights.
Compare athlete performances across different events and seasons.
Identify key factors that influence performance outcomes.

### Methodology:
- Data Collection: Source data from database 
- Data Cleaning: Use SQL to clean and validate the data.
- Tools: SQL (MySQL)

### Key SQL Queries:

#### 1.Nation has participated in all of the olympic games

      with a as 
        (select Team,games from Athlete_events group by Team,games
        )
        select Team,count(games)from a group by Team
        having count(games)= (select count(distinct games) from Athlete_events)

#### 2. Oldest athletes to win a gold medal

      with c as  (
        select * from Athlete_events where medal = 'gold' 
        ),
        b as (
        select id,name,sex,cast(age as int) a,height,weight,team,noc,games,year,city,sport,event,medal from c)
        select * from b
        where a = (select max(a) from b)

#### 3. Ratio of male and female athletes participated in all olympic games

     with a as (
       select distinct [name],sex from Athlete_events
       )
       select 
       try_convert(float,(select count(name) n1  from a where sex = 'f'
       ))/try_convert(float,(
       select count(name) n2 from a where sex = 'm'
       ))

  #### 4. top 5 athletes who have won the most medals

      with a as (
        select id,name,count(medal) as c from Athlete_events where medal != 'NA'
        group by id,[name]
        ) 
        select name,c from a where c in (select distinct top 5 c from a order by c desc)
        order by c desc

   #### 5. top 5 most successful countries in olympics

        select TOP 5( NOC) ,count(medal) from Athlete_events 
        where medal!= 'NA'
        group by NOC 
        order by count(Medal) desc

### Results and Insights:
   - Identified top-performing athletes and their average scores.
   - Analyzed performance trends across different age groups and events.
   - Compared performance variations across different seasons and genders

 
  
  This project demonstrates the use of SQL for comprehensive analysis of athlete performance data, providing valuable insights and actionable recommendations to enhance training and event management.













 
