
-- Looking at Total Population vs Vaccinations Per day
Select cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations
From Coviddeaths cd
Join Covidvaccinations cv
	On cd.location = cv.location
    and cd.date = cv.date
Where cd.continent != ''
order by 2,3;

-- Tallying Vaccination Numbers
Select cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations,
SUM(cast(cv.new_vaccinations as unsigned)) OVER (partition by cd.Location order by cd.location, cd.date) as VaccinationTally
From Coviddeaths cd
Join Covidvaccinations cv
	On cd.location = cv.location
    and cd.date = cv.date
Where cd.continent != ''
order by 2,3;

-- USE CTE 
-- Shows the percentage of vaccinated people vs the population
With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, VaccinationTally)
as
(
Select cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations,
SUM(cast(cv.new_vaccinations as unsigned)) OVER (partition by cd.Location order by cd.location, cd.date) as VaccinationTally
From Coviddeaths cd
Join Covidvaccinations cv
	On cd.location = cv.location
    and cd.date = cv.date
Where cd.continent != '' 
order by 2,3 )

Select *, (VaccinationTally/Population)*100 
From PopvsVac;


-- Temp Table Example
Drop Table if exists PercentagePopVaccinated;
Create Temporary Table PercentagePopVaccinated 
(
	Continent nvarchar(255),
    Location nvarchar(255),
    Date datetime,
    Population numeric,
    New_Vaccinations numeric,
    VaccinationTally numeric
);

Insert into PercentagePopVaccinated
Select cd.continent, cd.location, cd.date, cd.population, CONVERT(cv.new_vaccinations, SIGNED) AS new_vaccinations,
SUM(new_vaccinations ) OVER (partition by cd.Location order by cd.location, cd.date) as VaccinationTally
From Coviddeaths cd
Join Covidvaccinations cv
	On cd.location = cv.location
    and cd.date = cv.date
Where cd.continent != '' 
order by 2,3 ;

Select *, (VaccinationTally/Population)*100 
From PercentagePopVaccinated












