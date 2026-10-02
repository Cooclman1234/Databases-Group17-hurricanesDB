# Databases-Group17-hurricanesDB
A Databases course assignment by Group 17 building a speicifc Database to store differnet hurricanes over the years to evaluate their destruction over time. Doing so, we can identify if hurricanes have become more destructive over the years and if climate change plays any role in it

# Guide
All the necessary code is inside hurricane_database.ipynb
All necessary background infromation is inside this README.md
Comments are added ti understnad the different code cells

# Overall topic of the DB
The topic we chose was to look at the overall broad societal issue: climate change. However, we felt climate change was a little too broad of a topic and decided to narrow it down. We therefore looked for a recent, clearly climate change linked disaster to narrow down our focus. This led us to Hurricane Melissa in 2025 and the severe destruction it caused across the Caribbean. So, we narrowed our focus down to hurricanes in general and decided to specifically look at the destruction hurricanes over time, and how climate change relates to hurricanes.

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

In week 5, our task was to find real data and integrate it with the curretn structure of DB. For our DB, we decided to insert to different hurricanes and their MD date, destruction data and location data. our two hurricanes are:
Hurricane Melissa: [Visual Studio Code](https://www.nhc.noaa.gov/data/tcr/AL132025_Melissa.pdf)
Hurricane Ian: [Visual Studio Code](https://www.nhc.noaa.gov/data/tcr/AL092022_Ian.pdf)
