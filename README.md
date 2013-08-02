# node-mysql-nested

Converts mysql query result array (flat) to nested (multi-dimensional) object.

**Using:** node-mysql ([link](https://github.com/felixge/node-mysql))

## About

I have been working on AngularJS application. We have complex pages that require us to use multiple tables in a single query. After retrieving required information, in order to use it in controller, we had to manipulate resulting array, and convert it into nested javascript object. 

To make it more clear, let's go over an example. Let's say we have companies table, each company has company type. And, each company has zero or more improvement plans. Also, each improvement plan may have zero or more goals. We would like to have a resulting array that has goals property inside the improvement plan object which is also a property of upper object - company.

```javascript
var company = companies[0];
var companyType = company.companyType;
var firstGoal = company.improvementPlans[0].goals[0];
```

Since there was no library to make this work, and node-mysql is not giving me this, I wrote my own function and thought I could save someone's hours by sharing the source code. So, feel free to use it in anyway you want :)

## Usage

node-mysql library function mysqlConnection.query() takes 2 parameters: sql options and a callback function. 

Instead of this:

```javascript 
mysqlConnection.query(sqlString, function (err, rows) {});
```

Use this:

```javascript 
var options = { sql: sqlString, nestTables: true };
mysqlConnection.query(options, function (err, rows) {});
```

As you can see, we set nestTables to true. Taken from node-mysql documentation:

> By default, node-mysql will overwrite colliding column names in the order the columns are received from MySQL, causing some of the received values to be unavailable. However, you can also specify that you want your columns to be nested below the table name by using nestTable.

After setting nestTables to true, result array will be something like this:

```javascript 
[{
    table1: {
      fieldA: '...',
      fieldB: '...',
    },
    table2: {
      fieldA: '...',
      fieldB: '...',
    },
  }, ...]
```

Here is our SQL statement:

```sql
SELECT * FROM company
LEFT  JOIN company_type ON company.company_type_id = company_type.company_type_id
LEFT JOIN improvement_plan ON company.company_id = improvement_plan.company_id
LEFT JOIN improvement_plan_type ON improvement_plan.improvement_plan_type_id = improvement_plan_type.improvement_plan_type_id
LEFT JOIN goal ON improvement_plan.improvement_plan_id = goal.improvement_plan_id
```

You should use joins instead of WHEREs and ANDs in order to get related columns even if they have NULL value.

Then, we create nesting options array and push objects that has 'tableName' and 'key' properties and database table name and primary key column names as values of those  properties. node-mysql-nested function will use those to produce nested javascript object.

```javascript
    var nestingOptions = [
        { tableName : 'first_table_name', key: 'first_table_primary_key_column_name'},
        { tableName : 'second_table_name', key: 'second_table_primary_key_column_name' }
        ..
    ]
``` 

Please make sure that table names are in the same order as in your SQL statement. Otherwise it won't work.

Now, it is time to use our beloved function!

```javascript
mysqlConnection.query(options, function (err, rows) {
    
    var nestedRows = func.convertToNested(rows, nestingOptions);
    
    res.send(JSON.stringify(nestedRows));

});
```

And, this is it! Try to run example code to see the result.

## Options

Right now, there is just one option:

#### hasForeignKeyToUpperTable

While defining the nesting options, you can set hasForeignKeyToUpperTable property to true.
 
```javascript
    var nestingOptions = [
        { tableName : 'first_table_name', key: 'first_table_primary_key_column_name'},
        { tableName : 'second_table_name', key: 'second_table_primary_key_column_name' hasForeignKeyToUpperTable: true }
        ..
    ]
```

To understand why we would need this, let's go over the same example I gave earlier. We had companies table, and each company has improvement plans and a company type. As you see, each improvement plan has a foreign key (company_id) that relates it to a company. But it is not the same for company_type table. Company_type table doesn't have a foreign key that links each type to a company. 

To get the company type information in resulting array, we include it to nesting options array and set hasForeignKeyToUpperTable to true.

## Example

To illustrate how this function works, I included a simple application to the package. 

* node.js express app (under /server directory)
* mysql database (node-mysql-nested.sql)

### Installation

* Create a new database `node-mysql-nested` and import ***node-mysql-nested.sql***.

* Change to the project folder: `$cd node-mysql-nested/`  

* Install dependencies: `npm install`. This will install express and node-mysql.

* Start the node server: `node app` (if you don't have nodejs installed, go to: http://nodejs.org/)

* Now, open your browser and go to `http://localhost:3000`. You should be able to see a nested result object.

## Contact

 - Selman Kahya - hey@selmanh.com