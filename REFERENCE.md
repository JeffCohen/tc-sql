# Quick Reference to SQL

This is my simplified reference sheet for SQL.  I've left out
details for options that aren't commonly used.  As you get more familiar with SQL,
you'll want to consult the documentation for your specific implementation.


### SELECT

``` sql
SELECT
    [* | ALL | DISTINCT]
    column-name [AS alias] [, column-name ...]
    [FROM table [table-alias]]
    [WHERE where_condition]
    [INNER JOIN table-name ON ...]
    [ORDER BY {column-name} [ASC | DESC], ...]
    [GROUP BY column-name [ASC | DESC], ...]
    [HAVING where_condition]
    [LIMIT row_count]
    [OFFSET offset]
```

Example:

``` sql
SELECT FirstName, LastName FROM Customers WHERE LastName = 'Smith';
SELECT Product, SUM(SalesAmt) FROM Sales GROUP BY Product;
```

A special note about searching for substrings: you can use the `LIKE` operator
combined with `%` wildcard characters:

``` sql
SELECT FirstName, LastName FROM Customers WHERE LastName LIKE '%mit%';
```

### CREATE TABLE

``` sql

CREATE TABLE [IF NOT EXISTS] table-name
    (column-name [BOOLEAN | INTEGER | FLOAT | DECIMAL | DATE | TIME | TIMESTAMP
                  | DATETIME | BINARY(length) | TEXT | VARCHAR(length) ]
      [NOT NULL | NULL]
      [DEFAULT default_value]
      [UNIQUE]
      [AUTO_INCREMENT]
      [PRIMARY KEY], ...)

    [table-options]
```

Example:

``` sql
CREATE TABLE Customers (ID PRIMARY KEY AUTO_INCREMENT, FirstName TEXT, LastName TEXT);
```
Need to delete an entire table including its schema definition? `DROP TABLE [tablename]`.

### INSERT

``` sql

INSERT [INTO] table-name
    [(column-name [, column-name] ...)]
    VALUES (value_list), ...

```

Example:

```
INSERT INTO Customers (FirstName, LastName) VALUES ("Cookie", "Monster"), ("Big", "Bird");
```

### DELETE

Watch out.  There's no undo.

``` sql
DELETE FROM tbl_name
  [WHERE where_condition]
  [ORDER BY ...]
  [LIMIT row_count]
```

Example:

``` sql
DELETE FROM Customers WHERE LastName = 'Monster';
```


### UPDATE

``` sql
UPDATE table-name
    SET
    column-name = value ...
    [WHERE where_condition]
    [ORDER BY ...]
    [LIMIT row_count]
```

Example:

``` sql

UPDATE Customers SET CreditCard = "1234" WHERE LastName = "Smith";

UPDATE Customers SET LastModified = NOW() WHERE id > 10000;
```

## Aggregation Functions

|Function|Description|
|---|---|
|MIN|	returns the smallest value in a given column|
|MAX|	returns the largest value in a given column|
|SUM|	returns the sum of the numeric values in a given column|
|AVG|	returns the average value of a given column|
|COUNT(*)|	returns the number of rows in a table|
