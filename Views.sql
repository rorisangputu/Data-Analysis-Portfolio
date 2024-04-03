-- Creating view to store data for visualization
-- Looking at countries with highest death count compared to population
Create View DeathCountvsPopulation as
Select Location, Population, MAX(total_deaths) as HighestDeaths, Max((total_deaths/population))*100 as DeathPercentage
From Coviddeaths
Where Continent != '' -- or IS NOT NULL
Group by Location, Population
order by DeathPercentage DESC;

SELECT * FROM deathcountvspopulation;