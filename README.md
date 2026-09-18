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

# Relational Schema of our ERD

PK are in [] and FK are given a start (*)

Meteorological_Data([MD_ID]:int NOT NULL, hurricane_ID*:int NOT NULL, location_id*:int NOT NULL, start_datetime:DATETIME, end_datetime:DATETIME, avg_wind_speed:decimal(6,2), total_rainfall:decimal(7,2), avg_temperature:decimal(5,2))

Hurricane([hurricane_ID]:int NOT NULL, name:varchar(120), start_datetime:DATETIME, end_datetime:DATETIME)

Destruction([destruction_ID]:int NOT NULL, MD_ID*:int NOT NULL, deaths_direct:int NOT NULL, deaths_indirect:int NOT NULL, infrastructure_damage_usd:int NOT NULL, economic_damage_overall_usd:int NOT NULL)

Location([location_ID]:int NOT NULL, region:varchar(120), country:varchar(120), latitude:decimal(9,6), longitude:decimal(9,6))
