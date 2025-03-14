import mysql.connector 
import csv

# column_data = list()

# with open('quote_data.csv', 'r') as file:
#     reader = csv.reader(file)
#     # next(reader)
    
#     for row in reader:
#         if row[0] != "": column_data.append(row[0])

db = mysql.connector.connect(
  host="nixos",
  user="root",
  password="",
  database="db_welons_prototype"
)

cur = db.cursor(dictionary = True)

# for row in column_data:
#     cur.execute(f"insert into name_lookup (name) values ('{row}')")

# db.commit()

cur.execute("""
select
            item.id,
            name_lookup.name,
            specs_lookup.specs,
            category_lookup.category,
            unit_lookup.unit,
            remarks_lookup.remarks,
            colors_lookup.color,
            item.total_qty,
            item.official_srp as srp,
            item.image_path
        from
            item
        inner join
            name_lookup on item.name_id=name_lookup.id
        inner join
            specs_lookup on item.specs_id=specs_lookup.id
        inner join
            category_lookup on item.category_id=category_lookup.id
        inner join
            unit_lookup on item.unit_id=unit_lookup.id
        inner join
            remarks_lookup on item.remarks_id=remarks_lookup.id
        inner join
            colors_lookup on item.color_id=colors_lookup.id
        where
            item.id = 3
""")

res = cur.fetchall()

cur.execute(f'select id, name_id, specs_id as specs from item')
res = cur.fetchall()

if res: print(res)

"""
select
  name_lookup.name,
  category_lookup.category,
  unit_lookup.unit,
  colors_lookup.color,
  item.total_qty,
  item.official_srp as srp
from item
inner join
  name_lookup on item.name_id = name
"""