Data Analysis Project - Renewable Energy Usage Analysis
Portfolio Data Analyst
Leonardo Ferreira Gonzalez
________________________________________________________________________________________________________


Summary:


1. Setup of Docker container and MySQL Database
2. Selecting an example data source and modeling the data
3. PowerBI development phase
4. Further considerations


________________________________________________________________________________________________________


1 Setup of Docker container and MySQL Database


In this phase, I establish a Docker container within the local environment and create a MySQL database within it to accommodate the forthcoming selected data. Leveraging the Windows PowerShell in conjunction with WSL (Windows Subsystem for Linux) is pivotal for this task. Ensure the installation of WSL through the following PowerShell command:


wsl --install


For documentation purposes, verify the Ubuntu version installed by executing:


cat /etc/*-release


DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=22.04
DISTRIB_CODENAME=jammy
DISTRIB_DESCRIPTION="Ubuntu 22.04.2 LTS"
PRETTY_NAME="Ubuntu 22.04.2 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.2 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy


        The next step was to install the docker inside the Linux environment, using these commands:


sudo apt-get install docker
sudo apt-get install docker-compose


Inside this folder, the "docker-compose.yml" file is created and tailored using the nano text editor:


mkdir mysql-database


Inside this folder, the "docker-compose.yml" file is created and tailored using the nano text editor:


nano docker-compose.yml


version: '3.1'


services:


mysql:
image: mysql
command: --default-authentication-plugin=mysql_native_password
restart: always
environment:
MYSQL_DATABASE: 'db'
MYSQL_USER: 'user'
MYSQL_PASSWORD: 'password'
MYSQL_ROOT_PASSWORD: 'password'
ports:
- '3306:3306'
volumes:
- ./my-db:/var/lib/mysql


With the Docker file configured, proceed to build, create, and initiate the service, encompassing the MySQL database's establishment and accessibility:


sudo docker-compose up -d

________________________________________________________________________________________________________


2 Selecting an example data source and modeling the data


        The chosen data for this project was found in Kaggle, in the following Datasets:


Renewable Energy World Wide: 1965~2022
[Link] https://www.kaggle.com/datasets/belayethossainds/renewable-energy-world-wide-19652022/code


Description: Total 17 files, 74 columns, worldwide, 57 Years of data. The Renewable Energy World Wide dataset is a comprehensive global renewable energy data collection from 1965 to 2022. The dataset includes information on hydropower, wind, solar, biofuel, and geothermal energy production worldwide.


Global Data on Sustainable Energy (2000-2020)
[LINK] https://www.kaggle.com/datasets/anshtanwar/global-data-on-sustainable-energy


Description: Uncover this comprehensive dataset showcasing sustainable energy indicators and other useful factors across all countries from 2000 to 2020. Dive into vital aspects such as electricity access, renewable energy, carbon emissions, energy intensity, Financial flows, and economic growth. Compare nations, track progress towards Sustainable Development Goal 7, and gain profound insights into global energy consumption patterns over time.


        After downloading the data I chose to use DBeaver to connect and test the MySQL database created, using the following steps according to the yml file:


Serverhost: localhost
Port: 3306
Database: db
User: user
Password: password
Server Time Zone: Auto-detect
Local Client: MySQL Binaries


        Inside DBeaver I inserted the CSV files into the database, creating tables for each of them:


01 renewable-share-energy.csv
02 modern-renewable-energy-consumption.csv
03 modern-renewable-prod.csv
04 share-electricity-renewables.csv
05 hydropower-consumption.csv
06 hydro-share-energy.csv
07 share-electricity-hydro.csv
08 wind-generation.csv
09 cumulative-installed-wind-energy-capacity-gigawatts.csv
10 wind-share-energy.csv
11 share-electricity-wind.csv
12 solar-energy-consumption.csv
13 installed-solar-PV-capacity.csv
14 solar-share-energy.csv
15 share-electricity-solar.csv
16 biofuel-production.csv
17 installed-geothermal-capacity.csv
global-data-on-sustainable-energy.csv


        The next step was to rename the files and the columns inside each one of them with the purpose of preparation for SQL naming and statement rules, this part of the code done in the SQL console inside DBeaver was not attached to the project. After renaming the files I decided to unify all data inside one single table. This process carried out within the DBeaver SQL console, is documented in the attached "SQL-COMMANDS.sql" file available on GitHub in the same folder as this document.


________________________________________________________________________________________________________


3 PowerBI development phase


Screen 1: World evolution


Analysis by continent which provides a vision of the usage and production evolution of the main categories of renewable energy (wind, hydraulic, and solar) from 1960 to 2021. Also delivers a view that shows the representativeness of renewable energy in comparison with non-renewable energy usage considering the global production from 1960 and 2021. This analysis shows us that even though after the year 2000 we can observe a huge increase in renewable energy production last year's data (2021) show us that only 13% of global production. At last, the view delivers a vision of the percentage of each kind of renewable energy production by continent, showing us that this is the oldest kind of renewable energy used (records show us a relevant percentage already in the first year of data, 1960) and also that is the most significant until today.


Screen 2: Top producers


This segment presents a global distribution of major renewable energy types and highlights leading countries in each energy category.


Screen 3: Brazil


Brings a historical analysis of Brazil’s usage of renewable sources of energy (TWh), the energetic renewable matrix by the percentage of usage, highlighting the use of hydraulic sources, and also brings an analysis of GDP Growth and GDP Per Capita in parallel with an analysis of the relation of CO2 Emissions and renewable sources usage, enlightening a period of drought period that implied an increase of electricity prices, one of the direct impacts on the economy and also a period that Brazil reduced significantly the usage of renewable sources for other fossil alternatives of energy and the consequent a spike on CO2 emissions.


________________________________________________________________________________________________________


4 Further considerations


        The objective of this project was to demonstrate the knowledge of different tools by its author, the chosen sources by the authors of the datasets Ansh Tanwar and Belayet Hossain presented some inconsistencies between each other and also with different sources found by me in governmental agencies and environmental journalists, I tried to choose the data that was closer to reality, but I believe that even different methods of research can imply in some inconsistencies. For further analysis of the theme I would choose information from different sources, e.g.:


* International Energy Agency (IEA)
* Bloomberg New Energy Finance
* IRENA
* World Resources Institute (WRI)


        Also, I would try to connect the analysis of the usage evolution with information about the opportunities of each country to produce more renewable energy, bringing information about the water volumes in rivers, sun intensity throughout the year, abundance of biomass resources consequence of significant agricultural activities and waste volume opportunities.