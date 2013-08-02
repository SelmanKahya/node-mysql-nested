var express = require('express')
    , http = require('http')
    , path = require('path')
    , path = require('path')
    , mysql = require('mysql')
    , func = require('.././func.js');

var mySQLConfiguration = {
    hostname:"localhost",
    database:"node-mysql-nested",
    user: "root",
    password: "",
    port: "3306"
};

var mysqlConnection = mysql.createConnection(mySQLConfiguration);

var app = express();

// all environments
app.set('port', process.env.PORT || 3000);
app.use(express.logger('dev'));
app.use(express.bodyParser());
app.use(express.methodOverride());
app.use(app.router);
app.use(express.static(path.join(__dirname, 'public')));

// development only
if ('development' == app.get('env')) {
  app.use(express.errorHandler());
}

// handles request (route: /)
var indexHandler = function(req, res) {

    var sql = 'SELECT * FROM company ' +
        'LEFT  JOIN company_type ON company.company_type_id = company_type.company_type_id ' +
        'LEFT JOIN improvement_plan ON company.company_id = improvement_plan.company_id ' +
        'LEFT JOIN improvement_plan_type ON improvement_plan.improvement_plan_type_id = improvement_plan_type.improvement_plan_type_id ' +
        'LEFT JOIN goal ON improvement_plan.improvement_plan_id = goal.improvement_plan_id ';

    var nestingOptions = [
        { tableName : 'company', key: 'company_id'},
        { tableName : 'company_type', key: 'company_type_id', hasForeignKeyToUpperTable: false},
        { tableName : 'improvement_plan', key: 'improvement_plan_id'},
        { tableName : 'improvement_plan_type', key: 'improvement_plan_type_id', hasForeignKeyToUpperTable: false},
        { tableName : 'goal', key: 'goal_id'}
    ]

    // mysql.query() function takes nestedTables as an option parameter.
    // for details, see: https://github.com/felixge/node-mysql#joins-with-overlapping-column-names
    mysqlConnection.query({sql: sql, nestTables: true }, function (err, rows) {

        // error handling
        if (err){
            console.log('Internal error: ', err);
            res.send("Mysql query execution error!");
        }

        else {
            var nestedRows = func.convertToNested(rows, nestingOptions);
            res.send(JSON.stringify(nestedRows));
        }

    });

}

app.get('/', indexHandler);

http.createServer(app).listen(app.get('port'), function(){
  console.log('Express server listening on port ' + app.get('port'));
});
