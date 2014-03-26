# students.rb

# Add a student
# Delete a student
# Show a list of all students
# Show a list of students with a particular first_name
# Show a list of students with any particular attribute

require 'sqlite3'
require_relative 'setup'

$db = SQLite3::Database.new "students.db"
$db.results_as_hash = true

class Student
  attr_reader :id, :created_at, :updated_at
  attr_accessor :first_name, :last_name, :email, :location, :birthdate

	def initialize(params)
    @id = params["id"]
		@first_name = params["first_name"]
		@last_name = params["last_name"]
		@email = params["email"]
		@location = params["location"]
		@birthdate = params["birthdate"]
		@created_at = params["created_at"]
		@updated_at = params["updated_at"]
	end

  def self.all
    array = $db.execute('SELECT * FROM students;')
    puts array.inspect
    array.map! {|test_subjects| Student.new(test_subjects)}
  end

  def self.where(condition, *value)
    $db.execute("SELECT * FROM students WHERE #{condition}", *value)
  end

	def add
    $db.execute(
      "
      INSERT INTO students(first_name, last_name, email, location, birthdate, created_at, updated_at)
      VALUES ( ?, ?, ?, ?, ?, DATETIME('now'), DATETIME('now'))",
      [@first_name, @last_name, @email, @location, @birthdate]
    );
	end

	def delete
    $db.execute(
      <<-SQL

      SQL
    )
	end

end


StudentDB.setup
StudentDB.seed
puts "After seed--------------------------------"
puts $db.execute('SELECT * FROM students').inspect


sally = Student.new({ "first_name" => "Sally", "last_name" => "Butterfield",
                      "email" => "sbutterfield@dbc.com", "location" => "Detroit",
                      "birthdate" => "1989-02-03"})
puts "After making Sally --------------------------------"
sally.add


puts Student.all.inspect








