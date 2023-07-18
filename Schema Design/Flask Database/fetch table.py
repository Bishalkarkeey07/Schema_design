from flask import Flask
from flask_mysqldb import MySQL
from flask import Flask, request
from flask_restful import Api, Resource

app = Flask(__name__)
api = Api(app)

app.config['MYSQL_HOST'] = 'localhost'  
app.config['MYSQL_USER'] = 'root' 
app.config['MYSQL_PASSWORD'] = 'Sagarmatha@123'  
app.config['MYSQL_DB'] = 'tasksql'  


mysql = MySQL(app)
@app.route('/')
def index():
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM raw")
    data = cur.fetchall()
    cur.close()
    return str(data)



if __name__ == '__main__':
    app.run()