from flask import Flask, request, jsonify
from flask_restful import Api, Resource
from flask_mysqldb import MySQL

app = Flask(__name__)
api = Api(app)

app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'Sagarmatha@123'
app.config['MYSQL_DB'] = 'new_schema'

mysql = MySQL(app)

class BaseResource(Resource):
    def __init__(self):
        self.methods = {}

    def get(self, report_type=None):
        return {'message': 'GET method call for database'}

    def post(self, report_type=None):
        sdate = request.json['sdate']
        edate = request.json['edate']
        accountid = request.json['accountid']
        return {'message': f'POST method call with sdate: {sdate}, edate: {edate}, accountid: {accountid}'}

class homeresource_Req():
    def __init__(self, sdate, edate, accountid):
        self.cur = mysql.connection.cursor()
        self.sdate = sdate
        self.edate = edate
        self.accountid = accountid

    def execute_query(self, query):
        self.cur.execute(query)
        data = self.cur.fetchall()
        self.cur.close()
        return data

    def glance(self):
        query = f"SELECT SUM(spend) AS totalspend, accountid FROM fact_table WHERE fdate BETWEEN '{self.sdate}' AND '{self.edate}' AND accountid = {self.accountid} GROUP BY accountid"
        print(self.sdate)       

        data = self.execute_query(query)
        print(data)
        result = []
        for row in data:
            result.append({
                'totalspend': row[0],
                'accountid': row[1]
            })

        return jsonify(result)

    def daywise(self):
        query = f"SELECT SUM(spend) AS totalspend, accountid, DAY(fdate) AS day FROM fact_table WHERE fdate BETWEEN '{self.sdate}' AND '{self.edate}' AND accountid = {self.accountid} GROUP BY accountid, day"

        data = self.execute_query(query)
        print(data)
        result = []
        for row in data:
            result.append({
                'totalspend': row[0],
                'accountid': row[1],
                'day': row[2] if len(row) > 2 else None
            })

        return jsonify(result)

class HomeResource(BaseResource):
    def __init__(self):
        super().__init__()
        sdate = request.json.get('sdate')
        edate = request.json.get('edate')
        accountid = request.json.get('accountid')
        self.homeresource_Req = homeresource_Req(sdate, edate, accountid)
        self.methods = {
            'glance': self.homeresource_Req.glance,
            'daywise': self.homeresource_Req.daywise
        }

    def get(self, report_type=None):
        print(report_type)
        if report_type in self.methods:
            return self.methods[report_type]()
        return super().get(report_type)


resources = [
    (['/home', '/home/', '/home/<string:report_type>'], HomeResource)
]

# Dynamically handle resources
for routes, resource_class in resources:
    api.add_resource(resource_class, *routes)

if __name__ == '__main__':
    app.run(debug=True)
