import sqlite3
import pandas as pd

file_csv = pd.read_csv("vehicles.csv")
df = pd.DataFrame(file_csv, columns=['year','make','model','VClass','cylinders','displ','trany','city08','highway08','comb08'])
df = df.dropna(subset=['cylinders'])
df = df[df.ix[:,'displ'] != 0]
conn = sqlite3.connect("vehicles.db")
df.to_sql(con=conn, name='vehicles', if_exists='replace',index=False, flavor='sqlite')
conn.commit()
conn.close()
