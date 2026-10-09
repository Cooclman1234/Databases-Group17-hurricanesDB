import getpass

import mysql.connector
import pandas as pd

FILE = "/FULL/PATH/TO/Databases-Group17-hurricanesDB/week5/Databases-week5-task.xlsx"
d = pd.read_excel(FILE, sheet_name="destruction_entity", header=4)
m = pd.read_excel(FILE, sheet_name="meteorological_data", header=4)
bad = d[d["MD_ID"].notna() & ~d["MD_ID"].isin(m["MD_ID"])]
print(bad[["destruction_ID", "MD_ID"]].assign(excel_row=bad.index + 6))


SHEETS = [("hurricane_entity", "Hurricane"), ("location_entity", "Location"),
          ("meteorological_data", "MeteorologicalData"), ("destruction_entity", "Destruction")]

conn = mysql.connector.connect(host="localhost", user="root", database="hurricanes",
                               password=getpass.getpass("MySQL password: "))
cur = conn.cursor()
# keep ID 0 as 0 even if an ID column is AUTO_INCREMENT
cur.execute("SET SESSION sql_mode = CONCAT_WS(',', @@sql_mode, 'NO_AUTO_VALUE_ON_ZERO')")


def clean(col, v):
    if pd.isna(v):
        return None                                   # empty cell -> NULL
    if isinstance(v, pd.Timestamp):
        return v.to_pydatetime()
    if col.endswith("_datetime") and isinstance(v, str):
        return pd.to_datetime(v.replace("UTC", "").strip()).to_pydatetime()
    if col.endswith("_usd") and isinstance(v, str):
        return int(v.replace("$", "").replace(".", ""))   # '$2.500.000.000'
    if hasattr(v, "item"):
        v = v.item()
    return int(v) if isinstance(v, float) and v.is_integer() else v


try:
    # stop early if a table already has rows (this is what causes "Duplicate entry")
    for _, table in SHEETS:
        cur.execute(f"SELECT COUNT(*) FROM {table}")
        n = int(str((cur.fetchone() or (0,))[0]))  # type: ignore
        if n:
            raise RuntimeError(f"{table} already has {n} rows. Empty the tables first (Destruction, Meteorological_Data, Location, Hurricane).")

    for sheet, table in SHEETS:
        df = pd.read_excel(FILE, sheet_name=sheet, header=4).dropna(how="all")  # headers on row 5
        df = df[df.iloc[:, 0].notna()]                                          # drop stray text rows
        cur.execute(f"SHOW COLUMNS FROM {table}")
        db_cols = {str(r[0]).lower(): str(r[0]) for r in cur.fetchall()}  # type: ignore
        cols = [c for c in map(str, df.columns) if c.lower() in db_cols]        # skips 'source'
        df = df[cols]
        sql = (f"INSERT INTO {table} ({', '.join(db_cols[c.lower()] for c in cols)}) "
               f"VALUES ({', '.join(['%s'] * len(cols))})")
        rows = [tuple(clean(c, v) for c, v in zip(cols, r)) for r in df.itertuples(index=False)]
        cur.executemany(sql, rows)
        print(table, len(rows), "rows")

    conn.commit()
    print("Done.")
except Exception:
    conn.rollback()   # undo everything so a failed run leaves no locks or half-loaded tables
    raise
finally:
    cur.close()
    conn.close()