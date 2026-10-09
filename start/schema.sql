CREATE DATABASE /*!32312 IF NOT EXISTS*/ `hurricanes_db`;
 USE `hurricanes_db`;

CREATE TABLE IF NOT EXISTS Hurricane (
    hurricane_id INTEGER PRIMARY KEY,
    name VARCHAR(120),
    start_datetime DATETIME,
    end_datetime DATETIME,
    source TEXT NOT NULL
); 

CREATE TABLE IF NOT EXISTS Location (
    location_id INTEGER PRIMARY KEY NOT NULL,
    region VARCHAR(120) NULL,
    country VARCHAR(120) NULL,
    latitude DECIMAL(9,6) NULL,
    longitude DECIMAL(9,6) NULL,
    source TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS MetereologicalData (
    md_id INTEGER PRIMARY KEY NOT NULL,
    hurricane_id INTEGER NOT NULL,
    location_id INTEGER NOT NULL,
    start_datetime DATETIME NULL,
    end_datetime DATETIME NULL,
    avg_wind_speed DECIMAL(6,2) NULL,
    total_rainfall DECIMAL(7,2) NULL,
    avg_temperature DECIMAL(5,2) NULL,
    source TEXT NOT NULL,
    FOREIGN KEY (hurricane_id) REFERENCES Hurricane(hurricane_id),
    FOREIGN KEY (location_id) REFERENCES Location(location_id)
);

CREATE TABLE IF NOT EXISTS Destruction (
    destruction_id INTEGER PRIMARY KEY NOT NULL,
    md_id INTEGER NOT NULL,
    deaths_direct INTEGER NULL,
    deaths_indirect INTEGER NULL,
    infrastructure_damage BIGINT NULL,
    economic_damage_overall_usd BIGINT NULL,
    source TEXT NOT NULL,
    FOREIGN KEY (md_id) REFERENCES MetereologicalData(md_id)
);