import sqlite3
import pandas as pd
# output = []
# file_input = open("vehicles.csv",'rU')
# colnames = file_input.readline()
# colnames = colnames.split(',')
#
# def find_col(str):
#     for i in range(len(colnames)):
#         if colnames[i] == str:
#             return i
# find_col('barrels08')
# for line in file_input.readlines():
#     data = line.split(',')
#     year = data[find_col('year')]
#     make = data[find_col('make')]
#     model = data[find_col('model')]
#     VClass = data[find_col('VClass')]
#     cylinders = data[find_col('cylinders')]
#     displ = data[find_col('displ')]
#     trany = data[find_col('trany')]
#     city08 = data[find_col('city08')]
#     highway08 = data[find_col('highway08')]
#     comb08 = data[find_col('comb08')]
#     line_output = (year, make, model, VClass, cylinders, displ, trany, city08, highway08, comb08)
#
#     if cylinders != '0' and cylinders != '' and cylinders != 'NA' and displ != '0' and displ != '' and displ != 'NA' and year != '0':
#         output.append(line_output)


file_csv = pd.read_csv("vehicles.csv")
df = pd.DataFrame(file_csv, columns=['year','make','model','VClass','cylinders','displ','trany','city08','highway08','comb08'])
#df.describe()
#df['displ'].value_counts()
df = df.dropna(subset=['cylinders'])
#df.index.values
df = df[df.ix[:,'displ'] != 0]
#df = df[df.ix[:,'displ'] != '-']
#df = df[df.ix[:,'cylinders'] != '-']
#df.shape
#df['cylinders'].value_counts()
# df[df.ix[:,'year'] == 1984]
conn = sqlite3.connect("vehicles.db")
#cursor = conn.cursor()
df.to_sql(con=conn, name='vehicles', if_exists='replace',index=False, flavor='sqlite')
#df.describe()
# cursor.execute('''CREATE TABLE IF NOT EXISTS vehicles
#              (year INTEGER,
#               make VARCHAR,
#               model VARCHAR,
#               VClass VARCHAR,
#               cylinders INTEGER,
#               displ INTEGER,
#               trany VARCHAR,
#               city08 INTEGER,
#               highway08 INTEGER,
#               comb08 INTEGER)''')
#
# cursor.executemany("INSERT INTO vehicles VALUES (?,?,?,?,?,?,?,?,?,?)",output)
#cursor.execute("SELECT COUNT(*) FROM vehicles")
#cursor.fetchall()
conn.commit()
conn.close()
