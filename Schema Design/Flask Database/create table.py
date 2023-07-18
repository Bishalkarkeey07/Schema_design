from flask import Flask
from flask_mysqldb import MySQL

app = Flask(__name__)
app.config['MYSQL_HOST'] = 'localhost'  
app.config['MYSQL_USER'] = 'root'  
app.config['MYSQL_PASSWORD'] = 'Sagarmatha@123'  
app.config['MYSQL_DB'] = 'tasksql'  

mysql = MySQL(app)

@app.route('/')
def index():
    cur = mysql.connection.cursor()
    cur.execute("CREATE TABLE IF NOT EXISTS New_Table (id INT PRIMARY KEY AUTO_INCREMENT, name VARCHAR(255), age INT,department VARCHAR(255))")
    mysql.connection.commit()
    cur.close()
    return "Table created successfully!"





    

if __name__ == '__main__':
    app.run()
