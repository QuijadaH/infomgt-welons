from flask import Flask, render_template, request, redirect, jsonify, url_for, flash
import mysql.connector 
import pickle
import os
# from flask_sqlalchemy import SQLAlchemy
# import requests

app = Flask(__name__)

# app.config['SQLALCHEMY_DATABASE_URI'] = "mysql+pymysql://root:@nixos/db_welons_prototype"
# app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

# db = SQLAlchemy(app)

db_config = {
  "host": "nixos",
  "user": "root",
  "password": "",
  "database": "db_welons_prototype"
}

def get_db_connection():
    return mysql.connector.connect(**db_config)

@app.route("/")
def index():        # should render to login screen
    return render_template("inventory/items.html")

@app.route("/dashboard")
def dashboard():
    return render_template("dashboard.html")

##########

@app.route("/items")
def items_inventory():
    try:
        con = get_db_connection()
        cur = con.cursor(dictionary = True)

        sql = f'''
        select
            id,
            name_id as name,
            specs_id as specs,
            category_id as category,
            unit_id as unit,
            remarks_id as remarks,
            color_id as color,
            total_qty,
            official_srp as srp,
            image_path
        from item
        '''
        cur.execute(sql)
        records = cur.fetchall()

        for record in records:
            for key, value in record.items():
                if key in ('id', 'total_qty', 'srp', 'image_path'): continue
                if value == None: continue

                cur.execute(f"select * from {key}_lookup where id = {value}")
                record[key] = cur.fetchone()[key]

        cur.close()
        con.close()
        
        print(records)

    except mysql.connector.Error as err: print(err)

    return render_template("inventory/items.html", items=records)

@app.route("/items/get-form-data")
def item_get_form_data():
    try:
        con = get_db_connection()
        cur = con.cursor()

        results = dict()

        for col in ['name', 'specs', 'color', 'category', 'unit', 'remarks']:
            cur.execute(f'select * from {col}_lookup')
            table = cur.fetchall()
            
            results[col] = list()
            for record in table: results[col].append(record[1])

        cur.close()
        con.close()

        return jsonify(results)
        
    except mysql.connector.Error as err:
        print(err)
        return jsonify({"message": ""})
    
@app.route("/items/create-item", methods=["POST"])
def create_item():
     # keys: item-image, item-name, item-specs, item-color, item-category, item-unit, item-srp, item-total-qty, item-remarks

    try:
        con = get_db_connection()
        cur = con.cursor()

        name_id = 'null'
        specs_id = 'null'
        category_id = 'null'
        unit_id = 'null'
        color_id = 'null'
        remarks_id = 'null'
        image_path = 'null'

        request_dict = request.form.to_dict()

        for key, value in request_dict.items():
            data = None

            if key in ('item-name', 'item-color', 'item-category'):
                data = f'"{value.upper()}"' if value != '' else 'null'
            elif key == 'item-unit':
                data = f'"{value.lower()}"' if value != '' else 'null'
            elif key in ('item-specs', 'item-remarks'):
                data = f'"{value}"' if value != '' else 'null'
            else:
                if value == "": request_dict[key] = 'default'
                data = value

            if data == 'null': continue

            if key == 'item-name':
                cur.execute(f'select * from name_lookup where name = {data}')
                res = cur.fetchone()

                if res: name_id = res[0]
                else:
                    cur.execute(f'insert into name_lookup (name) values ({data})')
                    con.commit()

                    cur.execute(f'select * from name_lookup where name = {data}')
                    name_id = cur.fetchone()[0]

            elif key == 'item-category':
                cur.execute(f'select * from category_lookup where category = {data}')
                res = cur.fetchone()

                if res: category_id = res[0]
                else:
                    cur.execute(f'insert into category_lookup (category) values ({data})')
                    con.commit()

                    cur.execute(f'select * from category_lookup where category = {data}')
                    category_id = cur.fetchone()[0]

            elif key == 'item-specs':
                cur.execute(f'select * from specs_lookup where specs = {data}')
                res = cur.fetchone()

                if res: specs_id = res[0]
                else:
                    cur.execute(f'insert into specs_lookup (specs) values ({data})')
                    con.commit()

                    cur.execute(f'select * from specs_lookup where specs = {data}')
                    specs_id = cur.fetchone()[0]

            elif key == 'item-unit':
                cur.execute(f'select * from unit_lookup where unit = {data}')
                res = cur.fetchone()

                if res: unit_id = res[0]
                else:
                    cur.execute(f'insert into unit_lookup (unit) values ({data})')
                    con.commit()

                    cur.execute(f'select * from unit_lookup where unit = {data}')
                    unit_id = cur.fetchone()[0]

            elif key == 'item-color':
                cur.execute(f'select * from color_lookup where color = {data}')
                res = cur.fetchone()

                if res: color_id = res[0]
                else:
                    cur.execute(f'insert into color_lookup (color) values ({data})')
                    con.commit()

                    cur.execute(f'select * from color_lookup where color = {data}')
                    color_id = cur.fetchone()[0]

            elif key == 'item-remarks':
                cur.execute(f'select * from remarks_lookup where remarks = {data}')
                res = cur.fetchone()

                if res: remarks_id = res[0]
                else:
                    cur.execute(f'insert into remarks_lookup (remarks) values ({data})')
                    con.commit()

                    cur.execute(f'select * from remarks_lookup where remarks = {data}')
                    remarks_id = cur.fetchone()[0]

        if request.files['item-image']:
            data = request.files['item-image']
            image_path = f'./static/{data.filename}'
            if not os.path.exists(image_path): 
                data.save(image_path)
                print('saved')
            image_path = f'"{image_path}"'

        sql = f'insert into item values ({request_dict['item-id']}, {name_id}, {specs_id}, {category_id}, {unit_id}, {remarks_id}, {color_id}, {request_dict['item-qt-desc']}, {request_dict['item-total-qty']}, {request_dict['item-srp']}, {image_path})'
        print(sql)

        cur.execute(sql)
        con.commit()

        cur.close()
        con.close()

    except mysql.connector.Error as err: print(err)

    return redirect(url_for('items_inventory'))

@app.route("/items/get-item-data", methods=["POST"])
def get_item_data():
    try:
        item_id = request.json['item_id']

        con = get_db_connection()
        cur = con.cursor(dictionary = True)

        sql = f'''
        select
            id,
            name_id as name,
            specs_id as specs,
            category_id as category,
            unit_id as unit,
            remarks_id as remarks,
            color_id as color,
            total_qty,
            official_srp as srp,
            image_path
        from item
        where item.id = {item_id}
        '''
        cur.execute(sql)
        record = cur.fetchone()

        for key, value in record.items():
            if key in ('id', 'total_qty', 'srp', 'image_path'): continue
            if value == None: continue

            cur.execute(f"select * from {key}_lookup where id = {value}")
            record[key] = cur.fetchone()[key]

        return jsonify(record)
        
    except mysql.connector.Error as err:
        print(err)
        return jsonify({"message": ""})

@app.route("/items/edit-item", methods=["POST"])
def update_item():
    try:
        con = get_db_connection()
        cur = con.cursor()

        request_dict = request.form.to_dict()

        item_id = request_dict['item-id']
        name_id = None
        specs_id = None
        category_id = None
        unit_id = None
        color_id = None
        remarks_id = None
        image_path = "null"


        for key, value in request_dict.items():
            data = None

            if key in ('item-name', 'item-color', 'item-category'):
                data = f'"{value.upper()}"' if value != '' else None
            elif key == 'item-unit':
                data = f'"{value.lower()}"' if value != '' else None
            elif key in ('item-specs', 'item-remarks'):
                data = f'"{value}"' if value != '' else None
            else:
                if value == "": request_dict[key] = 'default'
                data = value

            if key == 'item-name':
                cur.execute(f'select * from name_lookup where name = {data}')
                res = cur.fetchone()

                if res: name_id = res[0]
                else:
                    cur.execute(f'insert into name_lookup (name) values ({data})')
                    con.commit()

                    cur.execute(f'select * from name_lookup where name = {data}')
                    name_id = cur.fetchone()[0]

            elif key == 'item-category':
                cur.execute(f'select * from category_lookup where category = {data}')
                res = cur.fetchone()

                if res: category_id = res[0]
                else:
                    cur.execute(f'insert into category_lookup (category) values ({data})')
                    con.commit()

                    cur.execute(f'select * from category_lookup where category = {data}')
                    category_id = cur.fetchone()[0]

            elif key == 'item-specs':
                cur.execute(f'select * from specs_lookup where specs = {data}')
                res = cur.fetchone()

                if res: specs_id = res[0]
                else:
                    cur.execute(f'insert into specs_lookup (specs) values ({data})')
                    con.commit()

                    cur.execute(f'select * from specs_lookup where specs = {data}')
                    specs_id = cur.fetchone()[0]

            elif key == 'item-unit':
                cur.execute(f'select * from unit_lookup where unit = {data}')
                res = cur.fetchone()

                if res: unit_id = res[0]
                else:
                    cur.execute(f'insert into unit_lookup (unit) values ({data})')
                    con.commit()

                    cur.execute(f'select * from unit_lookup where unit = {data}')
                    unit_id = cur.fetchone()[0]

            elif key == 'item-color':
                cur.execute(f'select * from color_lookup where color = {data}')
                res = cur.fetchone()

                if res: color_id = res[0]
                else:
                    cur.execute(f'insert into color_lookup (color) values ({data})')
                    con.commit()

                    cur.execute(f'select * from color_lookup where color = {data}')
                    color_id = cur.fetchone()[0]

            elif key == 'item-remarks':
                cur.execute(f'select * from remarks_lookup where remarks = {data}')
                res = cur.fetchone()

                if res: remarks_id = res[0]
                else:
                    cur.execute(f'insert into remarks_lookup (remarks) values ({data})')
                    con.commit()

                    cur.execute(f'select * from remarks_lookup where remarks = {data}')
                    remarks_id = cur.fetchone()[0]

        if request.files['item-image']:
            data = request.files['item-image']
            image_path = f'./static/{data.filename}'
            if not os.path.exists(image_path): 
                data.save(image_path)
                print('saved')
            image_path = f'"{image_path}"'
        else:
            cur.execute(f'select image_path from item where id = {item_id}')
            res = cur.fetchone()[0]
            if res:
                print('yay') 
                image_path = f'"{res}"'

        sql = f'''
        update item
        set
            name_id = {name_id},
            specs_id = {specs_id},
            category_id = {category_id},
            unit_id = {unit_id},
            remarks_id = {remarks_id},
            color_id = {color_id},
            total_qty = {request_dict['item-total-qty']},
            official_srp = {request_dict['item-srp']},
            image_path = {image_path}
        where id = {item_id}
        '''
        print(sql)

        cur.execute(sql)
        con.commit()

        cur.close()
        con.close()

    except mysql.connector.Error as err: print(err)

    return redirect(url_for('items_inventory'))

@app.route("/items/delete/<int:id>")
def delete_item(id):
    try:
        con = get_db_connection()
        cur = con.cursor()

        cur.execute(f'delete from item where id = {id}')
        con.commit()

        cur.close()
        con.close()
        
    except mysql.connector.Error as err: print(err)

    return redirect(url_for('items_inventory'))

########

@app.route("/prefabs")
def prefabs_inventory():
    try:
        con = get_db_connection()
        cur = con.cursor(dictionary = True)

        sql = f'''
        select
            id,
            name_id as name,
            specs_id as specs,
            color_id as color,
            quantity as qty,
            official_srp as srp
        from prefab
        '''
        cur.execute(sql)
        records = cur.fetchall()

        for record in records:
            for key, value in record.items():
                if key in ('id', 'qty', 'srp'): continue
                if value == None: continue

                cur.execute(f"select * from {key}_lookup where id = {value}")
                record[key] = cur.fetchone()[key]

        cur.close()
        con.close()

    except mysql.connector.Error as err: print(err)

    return render_template("inventory/prefabs.html", prefabs=records)

@app.route("/prefabs/get-form-data")
def prefab_get_form_data():
    try:
        con = get_db_connection()
        cur = con.cursor()

        results = dict()

        for col in ['name', 'specs', 'color']:
            cur.execute(f'select * from {col}_lookup')
            table = cur.fetchall()
            
            results[col] = list()
            for record in table: results[col].append(record[1])

        cur.close()
        con.close()

        return jsonify(results)
        
    except mysql.connector.Error as err:
        print(err)
        return jsonify({"message": ""})
    
@app.route("/prefabs/create-prefab", methods=["POST"])
def create_prefab():
     # keys: item-image, item-name, item-specs, item-color, item-category, item-unit, item-srp, item-total-qty, item-remarks

    try:
        con = get_db_connection()
        cur = con.cursor()

        name_id = 'null'
        specs_id = 'null'
        color_id = 'null'

        request_dict = request.form.to_dict()

        for key, value in request_dict.items():
            data = None

            if key in ('prefab-name', 'prefab-color'):
                data = f'"{value.upper()}"' if value != '' else 'null'
            elif key in ('prefab-specs'):
                data = f'"{value}"' if value != '' else 'null'
            else:
                if value == "": request_dict[key] = 'default'
                data = value

            if data == 'null': continue

            if key == 'prefab-name':
                cur.execute(f'select * from name_lookup where name = {data}')
                res = cur.fetchone()

                if res: name_id = res[0]
                else:
                    cur.execute(f'insert into name_lookup (name) values ({data})')
                    con.commit()

                    cur.execute(f'select id from name_lookup where name = {data}')
                    name_id = cur.fetchone()[0]

            elif key == 'prefab-specs':
                cur.execute(f'select * from specs_lookup where specs = {data}')
                res = cur.fetchone()

                if res: specs_id = res[0]
                else:
                    cur.execute(f'insert into specs_lookup (specs) values ({data})')
                    con.commit()

                    cur.execute(f'select id from specs_lookup where specs = {data}')
                    specs_id = cur.fetchone()[0]

            elif key == 'prefab-color':
                cur.execute(f'select * from color_lookup where color = {data}')
                res = cur.fetchone()

                if res: color_id = res[0]
                else:
                    cur.execute(f'insert into color_lookup (color) values ({data})')
                    con.commit()

                    cur.execute(f'select * from color_lookup where color = {data}')
                    color_id = cur.fetchone()[0]

        sql = f'insert into prefab values ({request_dict['prefab-id']}, {name_id}, {specs_id}, {color_id}, {request_dict['prefab-qt-desc']}, {request_dict['prefab-qty']}, {request_dict['prefab-srp']})'

        cur.execute(sql)
        con.commit()

        cur.close()
        con.close()

    except mysql.connector.Error as err: print(err)

    return redirect(url_for('prefabs_inventory'))

@app.route("/prefabs/get-prefab-data", methods=["POST"])
def get_prefab_data():
    try:
        prefab_id = request.json['prefab_id']

        con = get_db_connection()
        cur = con.cursor(dictionary = True)

        sql = f'''
        select
            id,
            name_id as name,
            specs_id as specs,
            color_id as color,
            quantity as qty,
            official_srp as srp
        from prefab
        where prefab.id = {prefab_id}
        '''
        cur.execute(sql)
        record = cur.fetchone()

        print(record)

        for key, value in record.items():
            if key in ('id', 'qty', 'srp'): continue
            if value == None: continue

            cur.execute(f"select * from {key}_lookup where id = {value}")
            record[key] = cur.fetchone()[key]

        return jsonify(record)
        
    except mysql.connector.Error as err:
        print(err)
        return jsonify({"message": ""})

@app.route("/items/get-prefab-item-data", methods=["POST"])
def get_prefab_item_data():
    try:
        prefab_id = request.json['prefab_id']

        con = get_db_connection()
        cur = con.cursor(dictionary = True)

        sql = f'''
        select
            id,
            name_id as name
        from
            prefab_item
        where
            id = {prefab_id}
        '''
        cur.execute(sql)
        record = cur.fetchone()

        for key, value in record.items():
            if key in ('id', 'total_qty', 'srp', 'image_path'): continue
            if value == None: continue

            cur.execute(f"select * from {key}_lookup where id = {value}")
            record[key] = cur.fetchone()[key]

        return jsonify(record)
        
    except mysql.connector.Error as err:
        print(err)
        return jsonify({"message": ""})

@app.route("/prefabs/edit-prefab", methods=["POST"])
def update_prefab():
    try:
        con = get_db_connection()
        cur = con.cursor()

        name_id = 'null'
        specs_id = 'null'
        color_id = 'null'

        request_dict = request.form.to_dict()

        prefab_id = request_dict['prefab-id']

        for key, value in request_dict.items():
            data = None

            if key in ('prefab-name', 'prefab-color'):
                data = f'"{value.upper()}"' if value != '' else 'null'
            elif key in ('prefab-specs'):
                data = f'"{value}"' if value != '' else 'null'
            else:
                if value == "": request_dict[key] = 'default'
                data = value

            if data == 'null': continue

            if key == 'prefab-name':
                cur.execute(f'select * from name_lookup where name = {data}')
                res = cur.fetchone()

                if res: name_id = res[0]
                else:
                    cur.execute(f'insert into name_lookup (name) values ({data})')
                    con.commit()

                    cur.execute(f'select id from name_lookup where name = {data}')
                    name_id = cur.fetchone()[0]

            elif key == 'prefab-specs':
                cur.execute(f'select * from specs_lookup where specs = {data}')
                res = cur.fetchone()

                if res: specs_id = res[0]
                else:
                    cur.execute(f'insert into specs_lookup (specs) values ({data})')
                    con.commit()

                    cur.execute(f'select id from specs_lookup where specs = {data}')
                    specs_id = cur.fetchone()[0]

            elif key == 'prefab-color':
                cur.execute(f'select * from color_lookup where color = {data}')
                res = cur.fetchone()

                if res: color_id = res[0]
                else:
                    cur.execute(f'insert into color_lookup (color) values ({data})')
                    con.commit()

                    cur.execute(f'select * from color_lookup where color = {data}')
                    color_id = cur.fetchone()[0]

        sql = f'insert into prefab values ({request_dict['prefab-id']}, {name_id}, {specs_id}, {color_id}, {request_dict['prefab-qt-desc']}, {request_dict['prefab-qty']}, {request_dict['prefab-srp']})'

        sql = f'''
        update prefab
        set
            name_id = {name_id},
            specs_id = {specs_id},
            color_id = {color_id},
            quantity = {request_dict['prefab-qty']},
            official_srp = {request_dict['prefab-srp']}
        where id = {prefab_id}
        '''

        cur.execute(sql)
        con.commit()

        cur.close()
        con.close()

    except mysql.connector.Error as err: print(err)

    return redirect(url_for('prefabs_inventory'))

@app.route("/prefabs/delete/<int:id>")
def delete_prefab(id):
    try:
        con = get_db_connection()
        cur = con.cursor()

        cur.execute(f'delete from prefab where id = {id}')
        con.commit()

        cur.close()
        con.close()
        
    except mysql.connector.Error as err: print(err)

    return redirect(url_for('prefabs_inventory'))

########

@app.route("/orders")
def orders():
    try:
        con = get_db_connection()
        cur = con.cursor(dictionary = True)

        sql = f'''
        select
            control_no,
            project_code,
            project_details,
            delivery_fee,
            grand_total,
            unit_status_id,
            order_status_id
        from project
        '''
        cur.execute(sql)
        records = cur.fetchall()

        for record in records:
            for key, value in record.items():
                if value == None: continue
                if key in ('unit_status_id', 'order_status_id'): 
                    cur.execute(f"select * from {key}_lookup where id = {value}")
                    record[key] = cur.fetchone()[key]

        cur.close()
        con.close()

    except mysql.connector.Error as err: print(err)

    return render_template("orders.html", prefabs=records)

########

@app.route("/transaction_logs")
def transcation_logs():
    return render_template("inventory/transactions.html")

if __name__ in "__main__":
    app.run(debug = True, host='0.0.0.0')