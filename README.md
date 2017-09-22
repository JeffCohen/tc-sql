# Workshop: Intro to Relational Databases


Welcome!  This is a very short introduction to relational databases.

We will focus on SQL and writing queries, but we will also discuss
relational design, tradeoffs, and pitfalls.

There's also a [Quick Reference Guide to SQL](REFERENCE.md) in this repository.
<hr>

## Before We Begin

**SQLite**

* I'll be using SQLite for this workshop: https://www.sqlite.org/
* You should install the latest version for your operating system.
* You can also use MySQL, Postgesql, or SQL Server because everything I demonstrate
should work on all database systems.

**Ruby and the SQLite3 Gem**

* For the Ruby portion of the workshop, I'm using Ruby 2.4, but any Ruby 2.1 or higher
should be fine.
* If you don't have the `sqlite3` gem yet, you can install it:

    `gem install sqlite3`

   However, if you're on Windows, this might not work - I've heard that some Windows installations can't cope with some of the C extensions included in the gem.  I have
   no expertise with that, so I'm afraid you're on your own for troubleshooting.

<hr>

## Using SQLite3

**Starting Up**

Open up your Terminal (Mac) or Command Prompt (`Start -> Run -> cmd` on Windows).

To start SQLite, just enter the following command:

`sqlite3`

To start SQLite with a specific database:

`sqlite3 {filename}`

For example,

`sqlite3 planets.sqlite3`

**Common Commands**

(Taken from the [online manual](https://sqlite.org/cli.html))

Aside from SQL queries, you can issue commands to the SQLite3 progam itself:

|Command|Description|
|-------|-----------|
|.exit|Exit SQLite and go back to your command prompt.|
|.schema|Displays the entire database schema.  You can specify an optional table name.|
|.tables|Shows the names of all of the tables in the database.|
|.mode column|Query results will be aligned nicely into a table format.|
|.headers on|This will show the column names in all query results.|
|.width {n}|Change the column width|
|.help|Get a list of all possible commands.|



## Other Online Resources

1. This might sound funny, but W3Schools has a decent reference guide
for all things SQL, including a live query composer that you can try
from within your browser.

    https://www.w3schools.com/sql/default.asp

2. Another decent option is the SQL section of GeeksForGeeks:

    http://www.geeksforgeeks.org/sql-tutorial/

There are lots of other online resources too, so feel free to find one that
works for you.  However, I do not recommend Codecademy or Khan Academy because their materials didn't feel well-organized (at least the last time I looked at them).

3. I got the Chinook sample database from here: https://github.com/lerocha/chinook-database

4. I like [Hirb](https://rubygems.org/gems/hirb/versions/0.7.3) for use with ActiveRecord.
