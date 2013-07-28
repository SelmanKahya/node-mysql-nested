var express = require('express')
    , http = require('http')
    , path = require('path')
    , path = require('path')
    , mysql = require('mysql');

var mySQLConfiguration = {
    hostname:"localhost",
    database:"my-db",
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

    var sql = 'SELECT * FROM test_table';

    // mysql.query() function takes nestedTables as an option parameter
    mysqlConnection.query({sql: sql, nestedTables: true }, function (err, rows) {

        // error handling
        if (err){
            console.log('Internal error: ', err);
            res.send("Mysql query execution error!");
        }

        else {
            res.send(rows);
        }

    });

}

app.get('/', indexHandler);

http.createServer(app).listen(app.get('port'), function(){
  console.log('Express server listening on port ' + app.get('port'));
});
