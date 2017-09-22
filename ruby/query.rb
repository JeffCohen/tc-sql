require 'active_record'
require 'active_support'


# connect to SQLite3
conn = ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'movies.sqlite3')

# Setup logging
console_logger = Logger.new(STDOUT)
console_logger.formatter = proc do |severity, datetime, progname, msg|
  "#{msg}\n"
end
ActiveRecord::Base.logger = console_logger

# To Do: Query the database using ActiveRecord objects
