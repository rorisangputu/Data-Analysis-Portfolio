-- Select Data that we are going to be using

Select *
From Coviddeaths;

-- Looking at Total Cases vs Total Deaths
-- Shows chance of death for Covid infected person
Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From Coviddeaths
Where Location = 'South Africa' -- Less than 4% chance of dying from Covid in SA
order by 1,2 ;

-- Looking at Total Cases vs Population
-- Shows Percentage of the population that was infected by Covid
Select Location, date, Population, total_cases, (total_cases/population)*100 as InfectedPercentage
From Coviddeaths
Where Location = 'South Africa' -- 2% of the population test positive for Covid by April 30, 2021
order by 1,2 ;

-- Looking at countries with highest infection rate compared to population
Select Location, Population, MAX(total_cases) as HighestInfectionCount, Max((total_cases/population))*100 as InfectedPercentage
From Coviddeaths
Where Continent != '' -- or IS NOT NULL
Group by Location, Population
order by InfectedPercentage DESC;

-- Looking at countries with highest death count compared to population
Select Location, Population, MAX(total_deaths) as HighestDeaths, Max((total_deaths/population))*100 as DeathPercentage
From Coviddeaths
Where Continent != '' -- or IS NOT NULL
Group by Location, Population
order by DeathPercentage DESC;

-- Countries with highest death rate
Select Location, Max(cast(Total_deaths as unsigned)) as TotalDeathCount
From Coviddeaths
Where Continent != '' -- or IS NOT NULL
Group by Location
Order by TotalDeathCount desc;

-- Total Deaths by Continent
Select location, Max(cast(Total_deaths as unsigned)) as TotalDeathCount
From Coviddeaths
Where continent = '' -- or IS  NULL
Group by location
Order by TotalDeathCount desc;

-- Global Numbers
Select date,  SUM(new_cases) as GlobalCases, Sum(cast(new_deaths as unsigned)) as GlobalDeaths, 
			Sum(cast(new_deaths as unsigned))/SUM(new_cases) * 100 as GlobalDeathPercentage
From Coviddeaths
Where continent != ''
Group by date
order by 1,2;

Select SUM(new_cases) as GlobalCases, Sum(new_deaths) as GlobalDeaths, 
			Sum(new_deaths)/SUM(new_cases) * 100 as GlobalDeathPercentage
From Coviddeaths
Where continent != ''
order by 1,2;



