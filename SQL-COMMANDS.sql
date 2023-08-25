CREATE TABLE renewable_energy (
    Entity VARCHAR(255),
    REYear INT,
    Renewables DOUBLE,
    GeoBiomass DOUBLE,
    Solar DOUBLE,
    Wind DOUBLE,
    Hydro DOUBLE,
    ElecWind DOUBLE,
    ElecHydro DOUBLE,
    ElecSolar DOUBLE,
    Other DOUBLE,
    ShareRenewables DOUBLE,
    HydroCons DOUBLE,
    HydroSharePrim DOUBLE,
    HydroShare DOUBLE,
    GenWind DOUBLE,
    WindCapacity DOUBLE,
    WindSharePrim DOUBLE,
    WindShare DOUBLE,
    SolarCons DOUBLE,
    SolarInst DOUBLE,
    SolarSharePrim DOUBLE,
    SolarShare DOUBLE,
    BiofuelProd DOUBLE,
    GeothermalCap DOUBLE,
    AccessPP DOUBLE,
    AccessCleanFuels DOUBLE,
    REGenCapPC DOUBLE,
    FinflowsUS DOUBLE,
    REShareEC DOUBLE,
    ElecFossil DOUBLE,
    ElecNuclear DOUBLE,
    ElecRenewable DOUBLE,
    ElecLowCarb DOUBLE,
    PrimEnConsPC DOUBLE,
    EnergyIntLevel DOUBLE,
    CO2Emissions DOUBLE,
    RenewablesPPrim DOUBLE,
    GDPGrowth DOUBLE,
    GDPPC DOUBLE,
    Density DOUBLE,
    LandArea VARCHAR(50),
    Latitude VARCHAR(50),
    Longitude VARCHAR(50)
);

ALTER TABLE renewable_energy
ADD PRIMARY KEY (Entity, REYear);

#1

INSERT INTO renewable_energy (Entity, REYear, Renewables) 
SELECT  renewable_share_energy.Entity, renewable_share_energy.Year, renewable_share_energy.Renewables_equivalent_primary_energy
FROM renewable_share_energy

#2

INSERT INTO renewable_energy (Entity, REYear, GeoBiomass, Solar, Wind, Hydro) 
SELECT  modern_renewable_energy_consumption.Entity, modern_renewable_energy_consumption.Year, 
modern_renewable_energy_consumption.GeoBiomass_TWh_other, modern_renewable_energy_consumption.SolarGeneration_TWh,
modern_renewable_energy_consumption.WindGeneration_TWh, modern_renewable_energy_consumption.HydroGeneration_TWh
FROM modern_renewable_energy_consumption

ON DUPLICATE KEY UPDATE 
GeoBiomass = modern_renewable_energy_consumption.GeoBiomass_TWh_other,
Solar = modern_renewable_energy_consumption.SolarGeneration_TWh,
Wind = modern_renewable_energy_consumption.WindGeneration_TWh,
Hydro = modern_renewable_energy_consumption.HydroGeneration_TWh

#3

INSERT INTO renewable_energy (Entity, REYear, ElecWind, ElecHydro, ElecSolar, Other) 
SELECT  modern_renewable_prod.Entity, modern_renewable_prod.Year, 
modern_renewable_prod.Electricity_wind_TWh, modern_renewable_prod.Electricity_hydro_TWh,
modern_renewable_prod.Electricity_solar_TWh, modern_renewable_prod.Other_TWh
FROM modern_renewable_prod

ON DUPLICATE KEY UPDATE 
ElecWind = modern_renewable_prod.Electricity_wind_TWh,
ElecHydro = modern_renewable_prod.Electricity_hydro_TWh,
ElecSolar = modern_renewable_prod.Electricity_solar_TWh,
Other = modern_renewable_prod.Other_TWh

#4

INSERT INTO renewable_energy (Entity, REYear, ShareRenewables) 
SELECT  share_electricity_renewables.Entity, share_electricity_renewables.Year, 
share_electricity_renewables.Renewables_perc_electricity
FROM share_electricity_renewables

ON DUPLICATE KEY UPDATE 
ShareRenewables = share_electricity_renewables.Renewables_perc_electricity

#5

INSERT INTO renewable_energy (Entity, REYear, HydroCons) 
SELECT hydropower_consumption.Entity, hydropower_consumption.Year, 
hydropower_consumption.Electricity_hydro_TWh
FROM hydropower_consumption

ON DUPLICATE KEY UPDATE 
HydroCons = hydropower_consumption.Electricity_hydro_TWh

#6

INSERT INTO renewable_energy (Entity, REYear, HydroSharePrim) 
SELECT share_electricity_hydro.Entity, share_electricity_hydro.Year, 
share_electricity_hydro.hydro_share
FROM share_electricity_hydro

ON DUPLICATE KEY UPDATE 
HydroSharePrim = share_electricity_hydro.hydro_share

#7

INSERT INTO renewable_energy (Entity, REYear, HydroShare) 
SELECT hydro_share_energy.Entity, hydro_share_energy.Year, 
hydro_share_energy.hydro_share_prim
FROM hydro_share_energy

ON DUPLICATE KEY UPDATE 
HydroShare = hydro_share_energy.hydro_share_prim

#8

INSERT INTO renewable_energy (Entity, REYear, GenWind) 
SELECT wind_generation.Entity, wind_generation.Year, 
wind_generation.Electricity_wind_TWh
FROM wind_generation

ON DUPLICATE KEY UPDATE 
GenWind = wind_generation.Electricity_wind_TWh

#9

INSERT INTO renewable_energy (Entity, REYear, WindCapacity) 
SELECT cumulative_installed_wind_energy_capacity_gigawatts.Entity, cumulative_installed_wind_energy_capacity_gigawatts.Year, 
cumulative_installed_wind_energy_capacity_gigawatts.Wind_Capacity
FROM cumulative_installed_wind_energy_capacity_gigawatts

ON DUPLICATE KEY UPDATE 
WindCapacity = cumulative_installed_wind_energy_capacity_gigawatts.Wind_Capacity

#10

INSERT INTO renewable_energy (Entity, REYear, WindSharePrim) 
SELECT wind_share_energy.Entity, 
wind_share_energy.Year, 
wind_share_energy.wind_share_prim
FROM wind_share_energy

ON DUPLICATE KEY UPDATE 
WindSharePrim = wind_share_energy.wind_share_prim

#11

INSERT INTO renewable_energy (Entity, REYear, WindShare) 
SELECT share_electricity_wind.Entity, 
share_electricity_wind.Year, 
share_electricity_wind.wind_share
FROM share_electricity_wind

ON DUPLICATE KEY UPDATE 
WindShare = share_electricity_wind.wind_share

#12

INSERT INTO renewable_energy (Entity, REYear, SolarCons) 
SELECT solar_energy_consumption.Entity, 
solar_energy_consumption.Year, 
solar_energy_consumption.Electricity_solar_cons_TWh
FROM solar_energy_consumption

ON DUPLICATE KEY UPDATE 
SolarCons = solar_energy_consumption.Electricity_solar_cons_TWh

#13

INSERT INTO renewable_energy (Entity, REYear, SolarInst) 
SELECT installed_solar_PV_capacity.Entity, 
installed_solar_PV_capacity.Year, 
installed_solar_PV_capacity.Solar_Capacity_Installed
FROM installed_solar_PV_capacity

ON DUPLICATE KEY UPDATE 
SolarInst = installed_solar_PV_capacity.Solar_Capacity_Installed


#14

INSERT INTO renewable_energy (Entity, REYear, SolarSharePrim) 
SELECT solar_share_energy.Entity, 
solar_share_energy.Year, 
solar_share_energy.solar_share_prim
FROM solar_share_energy

ON DUPLICATE KEY UPDATE 
SolarSharePrim = solar_share_energy.solar_share_prim

#15

INSERT INTO renewable_energy (Entity, REYear, SolarShare) 
SELECT share_electricity_solar.Entity, 
share_electricity_solar.Year, 
share_electricity_solar.solar_share
FROM share_electricity_solar

ON DUPLICATE KEY UPDATE 
SolarSharePrim = share_electricity_solar.solar_share

#16

INSERT INTO renewable_energy (Entity, REYear, BiofuelProd) 
SELECT biofuel_production.Entity, 
biofuel_production.Year, 
biofuel_production.Biofuel_prod_TWh
FROM biofuel_production

ON DUPLICATE KEY UPDATE 
BiofuelProd = biofuel_production.Biofuel_prod_TWh

#17

INSERT INTO renewable_energy (Entity, REYear, BiofuelProd) 
SELECT biofuel_production.Entity, 
biofuel_production.Year, 
biofuel_production.Biofuel_prod_TWh
FROM biofuel_production

ON DUPLICATE KEY UPDATE 
BiofuelProd = biofuel_production.Biofuel_prod_TWh

#18

INSERT INTO renewable_energy (Entity, REYear, GeothermalCap) 
SELECT installed_geothermal_capacity.Entity, 
installed_geothermal_capacity.Year, 
installed_geothermal_capacity.Geothermal_Capacity
FROM installed_geothermal_capacity

ON DUPLICATE KEY UPDATE 
GeothermalCap = installed_geothermal_capacity.Geothermal_Capacity

#LAST

INSERT INTO renewable_energy (Entity, REYear, AccessPP, AccessCleanFuels, REGenCapPC,
FinflowsUS, REShareEC, ElecFossil, ElecNuclear, ElecRenewable, ElecLowCarb, PrimEnConsPC,
EnergyIntLevel, CO2Emissions, RenewablesPPrim, GDPGrowth, GDPPC, Density,
LandArea, Latitude, Longitude) 
SELECT global_data_on_sustainable_energy.Entity, 
global_data_on_sustainable_energy.Year, 
global_data_on_sustainable_energy.Access_to_electricity_pp,
global_data_on_sustainable_energy.Access_clean_fuels_cooking,
global_data_on_sustainable_energy.RE_generating_cap_per_capita,
global_data_on_sustainable_energy.Fin_flows_dev_countries_US,
global_data_on_sustainable_energy.RE_share_total_energy_cons_per,
global_data_on_sustainable_energy.Electricity_fossil_fuels_TWh,
global_data_on_sustainable_energy.Electricity_nuclear_TWh,
global_data_on_sustainable_energy.Electricity_renewables_TWh,
global_data_on_sustainable_energy.Low_carbon_electricity_per_elec,
global_data_on_sustainable_energy.Prim_energy_cons_per_capita_kWh_person,
global_data_on_sustainable_energy.Energy_intensity_level_prim,
global_data_on_sustainable_energy.Value_co2_emissions_kt_by_country,
global_data_on_sustainable_energy.Renewables_perc_eq_prim,
global_data_on_sustainable_energy.gdp_growth,
global_data_on_sustainable_energy.gdp_per_capita,
global_data_on_sustainable_energy.Density,
global_data_on_sustainable_energy.Land_Area_Km2,
global_data_on_sustainable_energy.Latitude,
global_data_on_sustainable_energy.Longitude

FROM global_data_on_sustainable_energy

ON DUPLICATE KEY UPDATE 
AccessPP = global_data_on_sustainable_energy.Access_to_electricity_pp,
AccessCleanFuels = global_data_on_sustainable_energy.Access_clean_fuels_cooking,
REGenCapPC = global_data_on_sustainable_energy.RE_generating_cap_per_capita,
FinflowsUS = global_data_on_sustainable_energy.Fin_flows_dev_countries_US,
REShareEC = global_data_on_sustainable_energy.RE_share_total_energy_cons_per,
ElecFossil = global_data_on_sustainable_energy.Electricity_fossil_fuels_TWh,
ElecNuclear = global_data_on_sustainable_energy.Electricity_nuclear_TWh,
ElecRenewable = global_data_on_sustainable_energy.Electricity_renewables_TWh,
ElecLowCarb = global_data_on_sustainable_energy.Low_carbon_electricity_per_elec,
PrimEnConsPC = global_data_on_sustainable_energy.Prim_energy_cons_per_capita_kWh_person,
EnergyIntLevel = global_data_on_sustainable_energy.Energy_intensity_level_prim,
CO2Emissions = global_data_on_sustainable_energy.Value_co2_emissions_kt_by_country,
RenewablesPPrim = global_data_on_sustainable_energy.Renewables_perc_eq_prim,
GDPGrowth = global_data_on_sustainable_energy.gdp_growth,
GDPPC = global_data_on_sustainable_energy.gdp_per_capita,
Density = global_data_on_sustainable_energy.Density,
LandArea = global_data_on_sustainable_energy.Land_Area_Km2,
Latitude = global_data_on_sustainable_energy.Latitude,
Longitude = global_data_on_sustainable_energy.Longitude