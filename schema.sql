-- ============================================================
-- Hurricanes Database — Schema
-- Converted from the Group 17 ERD (Hurricane / Location /
-- MeteorologicalData / Destruction)
-- ============================================================

PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS Hurricane (
    hurricane_id    INTEGER PRIMARY KEY,
    name            VARCHAR(120) NOT NULL,
    start_datetime  DATETIME NOT NULL,
    end_datetime    DATETIME NOT NULL,
    CHECK (end_datetime >= start_datetime)
);

CREATE TABLE IF NOT EXISTS Location (
    location_id INTEGER PRIMARY KEY,
    region      VARCHAR(120) NOT NULL,
    country     VARCHAR(120) NOT NULL,
    latitude    DECIMAL(9,6) NOT NULL CHECK (latitude BETWEEN -90 AND 90),
    longitude   DECIMAL(9,6) NOT NULL CHECK (longitude BETWEEN -180 AND 180)
);

CREATE TABLE IF NOT EXISTS MeteorologicalData (
    md_id            INTEGER PRIMARY KEY,
    hurricane_id     INTEGER NOT NULL,
    location_id      INTEGER NOT NULL,
    start_datetime   DATETIME NOT NULL,
    end_datetime     DATETIME NOT NULL,
    avg_wind_speed   DECIMAL(6,2) CHECK (avg_wind_speed >= 0),
    total_rainfall   DECIMAL(7,2) CHECK (total_rainfall >= 0),
    avg_temperature  DECIMAL(5,2),
    FOREIGN KEY (hurricane_id) REFERENCES Hurricane(hurricane_id)
        ON DELETE CASCADE,
    FOREIGN KEY (location_id) REFERENCES Location(location_id)
        ON DELETE RESTRICT,
    CHECK (end_datetime >= start_datetime)
);

CREATE TABLE IF NOT EXISTS Destruction (
    destruction_id                INTEGER PRIMARY KEY,
    md_id                         INTEGER NOT NULL UNIQUE,
    deaths_direct                 INTEGER NOT NULL CHECK (deaths_direct >= 0),
    deaths_indirect               INTEGER NOT NULL CHECK (deaths_indirect >= 0),
    infrastructure_damage_usd     BIGINT NOT NULL CHECK (infrastructure_damage_usd >= 0),
    economic_damage_overall_usd   DECIMAL(14,2) CHECK (economic_damage_overall_usd >= 0),
    FOREIGN KEY (md_id) REFERENCES MeteorologicalData(md_id)
        ON DELETE CASCADE
);

-- Helpful indexes for the FK lookups / advanced queries
CREATE INDEX IF NOT EXISTS idx_md_hurricane ON MeteorologicalData(hurricane_id);
CREATE INDEX IF NOT EXISTS idx_md_location  ON MeteorologicalData(location_id);
CREATE INDEX IF NOT EXISTS idx_destruction_md ON Destruction(md_id);
