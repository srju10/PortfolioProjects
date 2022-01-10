
select * from coviddeaths;

-- trying to analyze the data
select location,date, continent,total_cases, total_deaths, population
from coviddeaths
where continent != ''
order by 1,2;

-- infection to moratlity ratio
select continent,location,date, total_cases, total_deaths, round((total_deaths/total_cases) * 100,3) DeathPercentage
from coviddeaths
where continent != ''
order by 2,3;

-- Infection to population ratio
select location,date, population,total_cases, round((total_cases /population) * 100,3) PopulationPercentage
from coviddeaths
where location like '%State%'
and continent != ''
order by 1,2;

-- Location wise hightest infection rate
select continent,location, population,max(total_cases) TotalInfectionCount, round(max(total_cases /population) * 100,3) PopulationPercentage
from coviddeaths
-- where location like '%State%'
where continent != ''
group by continent,location, population
order by PopulationPercentage desc;

-- Locationwise maximum deathcounts
select continent,location,max(convert(total_deaths,SIGNED)) MaxDeathCounts
from coviddeaths
-- where location like '%State%'
where continent != ''
group by continent,location
order by MaxDeathCounts desc;

-- Location wise total death count
select continent,location, population,max(convert(total_deaths,SIGNED)) TotalDeathsCount, round(max(convert(total_deaths,SIGNED) /population) * 100,3) PopulationMortalityPercentage
from coviddeaths
-- where location like '%State%'
where continent != ''
group by continent,location, population
order by PopulationMortalityPercentage desc;

-- Continent and location wise total infection and mortality percentage
select continent,location, max(total_cases) MaxInfectedCounts, max(convert(total_deaths, SIGNED)) MaxDeathCounts, 
round(max(convert(total_deaths, SIGNED)) / max(total_cases)* 100, 3) mortalityPercentage
from coviddeaths
where continent!=''
group by location,continent
order by MaxInfectedCounts desc;

-- Global infected and mortality percentage

select sum(new_cases) globalInfectedcounts, sum(new_deaths) globalDeathcounts, round(sum(new_deaths)/sum(new_cases) * 100,3) MortalityPercentage
from coviddeaths
where continent!='';

-- Continent wise infection and mortality percentage
select continent,sum(new_cases) TotalInfectedcounts, sum(new_deaths) TotalDeathcounts, (sum(new_deaths)/sum(new_cases) * 100) MortaliltyPercentage
from coviddeaths
where continent!=''
group by continent;

-- Location and date wise infection and population percentage
select location, date, population, new_cases, sum(new_cases) over(partition by location order by location,date) totalCases,
round((sum(new_cases) over(partition by location order by location,date)/ population) *100,3) PopulationPercentage
from coviddeaths;



-- Codiv vaccinations table
select * from covidvaccinations;

select *
from coviddeaths d, covidvaccinations v
where d.location = v.location
and d.date = v.date

