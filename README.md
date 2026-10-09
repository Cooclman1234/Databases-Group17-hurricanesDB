# Databases-Group17-hurricanesDB
A Databases course assignment by Group 17 

# Guide
All the necessary code to query through our mySQL server is inside hurricane_database.ipynb
All necessary background infromation is inside this README.md
Comments are added to understand the different code cells

# Overall topic of the DB
The main question we wanted to answer: Have hurricanes have become more destructive since climate change started? To answer this, we wanted to create a Database that contains all informaion about a hurricane. Specifcally, we wanted to know its full course, meereological data and the destruction it has caused along the way. By gathering all this information, we can later answer, the main question.

# Why this topic?
The topic we chose was to look at the overall broad societal issue: climate change. However, we felt climate change was a little too broad of a topic and decided to narrow it down. We therefore looked for a recent, clearly climate change linked disaster to narrow down our focus. This led us to Hurricane Melissa in 2025 and the severe destruction it caused across the Caribbean. So, we narrowed our focus down to hurricanes in general and decided to specifically look at the destruction hurricanes over time, and how climate change relates to hurricanes.

# Stakeholder

- **Residents and communities in hurricane-prone regions** (e.g. the Caribbean): directly affected by hurricanes; understanding their impact helps with prevention and minimizing destruction.
- **Businesses offering hurricane-preparedness products and services**: help people make their homes and properties ready for climate disasters, understand more detailledly how hurricanes happen.
- **Governments and emergency response agencies**: coordinate disaster response and long-term resilience planning, and need to act quickly when a hurricane hits. They could understand how destructive hurricanes are becoming.
- **Insurance companies**: bear the financial risk of hurricane destruction. It would help them restructure their contracts, when it maybe comes out that hurricanes might get more destructive than before climate change.
- **The general public**: the aftermath of a hurricane shows the real and ongoing effects of climate change, which makes the issue relevant to everyone.

# Idea of our ERD
The idea of the ERD is to build a database in which many different hurricanes from all over the years can be stored and compared based on the destruction they caused in different locations and time periods. We want to use this database to later assess if hurricanes and hurricane destruction have intensified over time. We do know that data may not be available in the amounts we would need to prove this, yet we still chose this idea, because it could help answer this question. Where full time-series data is not available we will have to restrict comparisons to the subset of hurricanes which do have sufficient amounts of data. We want to see if the storm’s intensity is somehow related to climate change and this motivated our decision to examine the broader pattern of hurricane destruction over time.

# Our initial ERD

![Getting Started](./images/ERD-1.png)

# Explanation of our intial ERD

We basically have four main entities: Meteorological Data (MD), Hurricane, Destruction and Location. Each of the four entities do have an attribute to give each record their unique identity. Hurricane entity stores the basic data on the entity such as the start and end time and its name. The Meteorological Data (MD) entity represents a specific time window during which a specific hurricane was present at a specific location, along with the weather conditions recorded during that window.
One hurricane can pass through a location multiple times and a single location can be affected by multiple hurricanes over the years. This creates a many-to-many relationship.
The Meteorological Data entity resolves this relationship by recording links to exactly one hurricane and exactly one location, while a hurricane or location can be linked to multiple MD records.
Location entity stores each affected place independently of any hurricane and the destruction entity captures the outcome caused by the conditions recorded in a specific MD window. Destruction connects MD instead of directly connecting to the location and hurricane, because we think that destruction should be modelled as a consequence of a specific meteorological event at a specific place and time rather than an independent fact about the hurricane or location alone.

# Relational Schema and constraints of our intial ERD

PK are in [] and FK are given a start (*)

Meteorological_Data([MD_ID]:int NOT NULL, hurricane_ID*:int NOT NULL, location_ID*:int NOT NULL, start_datetime:DATETIME, end_datetime:DATETIME, avg_wind_speed:decimal(6,2), total_rainfall:decimal(7,2), avg_temperature:decimal(5,2))

Hurricane([hurricane_ID]:int NOT NULL, name:varchar(120), start_datetime:DATETIME, end_datetime:DATETIME)

Destruction([destruction_ID]:int NOT NULL, MD_ID*:int NOT NULL, deaths_direct:int NOT NULL, deaths_indirect:int NOT NULL, infrastructure_damage_usd:int NOT NULL, economic_damage_overall_usd:int NOT NULL)

Location([location_ID]:int NOT NULL, region:varchar(120), country:varchar(120), latitude:decimal(9,6), longitude:decimal(9,6))

# Pitch video

[Watch our pitch video](./video/pitch.mp4)

# Integrating real data into our Database

In week 5, our task was to find real data and integrate it with the curretn structure of DB. For our DB, we decided to insert to different hurricanes and their MD date, destruction data and location data.

## Sources of our data

We use two types of sources that complement each other: the NHC Tropical Cyclone reports give the course of each hurricane (Hurricane, Location and Meteorological Data entities), and post disaster damage reports give the destruction (Destruction entity). The exact page and table for every value is cited in the source column of each row in week5/Databases-week5-task.xlsx.

| Source | Used for | Published | Licence |
|---|---|---|---|
| [NHC Tropical Cyclone Report: Hurricane Melissa (AL132025)](https://www.nhc.noaa.gov/data/tcr/AL132025_Melissa.pdf) | Hurricane, Location, Meteorological Data, Destruction (deaths) | revised 19 May 2026 | US government work, public domain |
| [NHC Tropical Cyclone Report: Hurricane Ian (AL092022)](https://www.nhc.noaa.gov/data/tcr/AL092022_Ian.pdf) | Hurricane, Location, Meteorological Data, Destruction | 2 April 2023, revised 12 March 2026 | US government work, public domain |
| [NHC Tropical Cyclone Report: Hurricane Fiona (AL072022)](https://www.nhc.noaa.gov/data/tcr/AL072022_Fiona.pdf) | Hurricane, Location, Meteorological Data, Destruction | 23 March 2023 | US government work, public domain |
| [World Bank / GFDRR: GRADE report, Hurricane Melissa, Jamaica](https://www.gfdrr.org/sites/default/files/publication/GRADE%20Jamaica_FIN.pdf) ([landing page](https://www.gfdrr.org/en/JamaicaGRADE)) | Destruction: damage per Jamaican parish | 19 November 2025 | CC BY 3.0 IGO |
| [UNOCHA: Jamaica Hurricane Melissa Situation Report No. 4](https://www.unocha.org/publications/report/jamaica/jamaica-hurricane-melissa-situation-report-no-4-11-november) | Destruction: deaths per parish | data as of 11 November 2025 | OCHA website terms of use (no explicit licence stated) |
| [Jamaica Information Service: 45 confirmed deaths from Hurricane Melissa](https://jis.gov.jm/45-confirmed-deaths-from-hurricane-melissa/) | Destruction: deaths | 2025 | JIS website terms of use (no explicit licence stated) |
| [Jamaica Information Service: St. Elizabeth, St. James, Westmoreland sustained US$5.5 billion in damage](https://jis.gov.jm/st-elizabeth-st-james-westmoreland-sustained-us5-5-billion-in-damage-from-hurricane-melissa/) | Destruction: damage | 2025 | JIS website terms of use (no explicit licence stated) |
| [IDB blog: Jamaica after Hurricane Melissa](https://www.iadb.org/en/blog/economic-analysis/jamaica-after-hurricane-melissa-building-resilience-through-disaster-risk-financing) | Destruction: total economic damage of Melissa | 2026 | IDB website terms of use (no explicit licence stated) |


## Dataset creation and data cleaning

### How we built the dataset

There was no dataset that was already made that fit our ERD, so we built one by hand in `week5/Databases-week5-task.xlsx`, which has one sheet per entity (`hurricane_entity`, `location_entity`, `meteorological_data`, `destruction_entity`), with the column names of our schema plus three helper sheets:
- `best_track_ref` (Melissa) and `best_track_ref_Ian`: the 6-hourly "best track" tables (time, position, pressure, wind) copied from Table 1 of the NHC reports.
- `jamaica_parish_damage_ref`: damage per Jamaican parish from the GFDRR GRADE report.

In total the dataset contains **3 hurricanes** (Melissa 2025, Ian 2022, Fiona 2022), **99 locations**, **109 meteorological observations** and **29 destruction records**.

How each entity was filled:

- **Hurricane**: start = when the storm formed, end = when it dissipated, both from Table 1 of the NHC report.
- **Location**: one row per landfall point, weather station or ship position mentioned in the NHC reports. Ship positions are rounded to 0.1° and reused when several reports share a position.
- **Meteorological Data**: one row per hurricane passing a location. The time window is the period the hurricane affected that location (for example from peak intensity until it left Jamaica's coast).
  - `avg_wind_speed` is in **knots**. For landfalls it is the average of the best-track winds inside the window (computed with `AVERAGEIFS` on the best-track sheet). For stations and ships it is the single reported wind.
  - `total_rainfall` is in **mm**. Values reported in inches were converted (1 in = 25.4 mm).
- **Destruction**: linked to the Meteorological Data row of the place where the damage happened. Jamaican parish damage comes from the GRADE report, deaths from UNOCHA, JIS and the NHC reports.

### Data cleaning

| Issue | What we did |
|---|---|
| **Missing values.** The sources often don't report a value for a specific place (e.g. no temperature anywhere, no coordinates for Haiti because Melissa made no landfall there, no monetary damage estimate for Cuba, no split between direct and indirect deaths for Jamaica). | Left the cell empty, which becomes `NULL` in the database. `NULL` means "not reported by the source", never 0. The `source` column of each row explains why a value is missing. To allow this, we made these columns nullable (see the schema changes below). |
| **Locations without a country.** Ship reports are at sea. | `country` is `NULL` and `region` is "Open water (ship report position)". |
| **Date formats.** Times in the reports are written like "1200 UTC 28 Oct", and some cells were stored as text such as `2022-09-16 23:15 UTC`. | All times converted to `YYYY-MM-DD HH:MM:SS` in UTC. The loader removes the "UTC" text and converts strings to `DATETIME`. |
| **Money stored as text.** Some damage values were written as text like `$2.500.000.000`. | The loader removes `$` and the thousands separators and stores the value as `BIGINT` (US$). |
| **Mixed wind units.** NHC uses 1-minute sustained winds, but Cuban stations report 10-minute winds. | Stored as reported, in knots, and noted in the `source` column. |
| **Ditto marks.** In the Ian best-track table the stage column uses `"` for "same as above". | Filled down with the actual value. |
| **Duplicates and key errors.** | Every ID is unique, and every foreign key (`hurricane_id`, `location_id`, `MD_ID`) points to an existing row. We checked this in the notebook and fixed one Destruction row that referred to a non-existing `MD_ID` (123). |
| **Stray rows.** The sheets have a title and description above the header (row 5). | The loader reads from row 5 and skips empty or text-only rows. |



  


Due to data inconsistency, we had to make some new changes to the constraints of attributes of our schema. This is the new ERD:
![Getting Started](./images/ERD-2.png)

## Normalization Form of our updated DB structure

Even after changing the structure of the DB, the DB stays in 3NF.
new schema definiton:

## Relational Schema of our updated ERD

PK are in [] and FK are given a star (*)

Meteorological_Data([MD_ID]:int NOT NULL, hurricane_ID*:int NOT NULL, location_id*:int NOT NULL, start_datetime:DATETIME, end_datetime:DATETIME, avg_wind_speed:decimal(6,2) NULL, total_rainfall:decimal(7,2) NULL, avg_temperature:decimal(5,2) NULL, source:varchar(1000))

Hurricane([hurricane_ID]:int NOT NULL, name:varchar(120), start_datetime:DATETIME, end_datetime:DATETIME, source:varchar(1000) NOT NULL)

Destruction([destruction_ID]:int NOT NULL, MD_ID*:int NOT NULL, deaths_direct:int NULL, deaths_indirect:int NULL, infrastructure_damage_usd:BIGINT NULL, economic_damage_overall_usd:BIGINT NULL, source:varchar(1000) NOT NULL)

Location([location_id]:int NOT NULL, region:varchar(120) NULL, country:varchar(120) NULL, latitude:decimal(9,6) NULL, longitude:decimal(9,6) NULL, source:varchar(1000) NOT NULL)

### Explanation of relational Schema of our updated ERD

## Limitations of our updated DB

# Future Work
In the future, we want to gather more data on destruction from the specific places. As we have already expirienced when trying to add real destruction data into our DB, we have realized that there is not enough information regarding the destruction a hurricane has caused specfically at a location at a given time. This greatly limits us analyze how destructive hurricanes were, and makes it difficult to sum up all the overall economic damage a hurricane has caused. Another aspect we want to add to our DB is to connect it with an application. We want to create a web based application which would contain a timeline, where all the differnet hurricanes can be depicted, and when you click ona. specific hurricanes, you would get all the differnet information on its course, destruction and metereological data. But the main goal of this is to compare hurricanes, that happend before climate change and hurricnaes that happend since climate change started. Then we can see if hurricanes have become more destructive since climate change, which would answer the main question of this project.

# At last, replicate our DB!

tba
