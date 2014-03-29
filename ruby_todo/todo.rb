# What classes do you need?
require 'csv'

class ToDoView

  def show_list(data)
    data.each_with_index do |task, index|
      puts "#{index}: #{task[0]}"
    end
  end

  def view(arg)
    puts arg
  end

  def help
    puts "Commands:"
    puts "help    -displays this help page"
    puts "list    -shows every item of todo list"
    puts "add     -follow with new task to include on list"
    puts "delete  -follow with number of task you want to delete"
    
  end
end

##################################################

class ToDoControl

  def initialize
    @viewer = ToDoView.new
    @model = ToDoModel.new
    @model.load
  end

  def run(arg)
    @viewer.run(arg)
  end

  def list(*)
    @viewer.show_list(@model.data)
  end

  def add(task)
    @model.insert_task(task)
    @model.save
  end

  def delete(num)
    @model.remove_task(num.to_i)
    @model.save
  end

  def help(*)
    @viewer.help
  end
end

##################################################

class ToDoModel
  attr_reader :data

  def initialize(file_name = 'todo.csv')
    @data = []
    @file = file_name
  end

  def load
    CSV.foreach(@file) { |row| @data << row }
  end

  def save
    CSV.open(@file, "wb") do |csv|
      @data.each { |row| csv << row }
    end
  end

  def insert_task(new_item)
    @data << [new_item]
  end


  def remove_task(num)
    @data.delete_at(num)
  end

  def complete

  end
end

if ARGV[0] == nil
  ARGV[0] = "help"
end

ToDoControl.new.send(ARGV[0].to_s, ARGV[1..-1].join(" "))


# Remember, there are four high-level responsibilities, each of which have multiple sub-responsibilities:
# 1. Gathering user input and taking the appropriate action (controller)
# 2. Displaying information to the user (view)
# 3. Reading and writing from the todo.txt file (model)
# 4. Manipulating the in-memory objects that model a real-life TODO list (domain-specific model)

# Note that (4) is where the essence of your application lives.
# Pretty much every application in the universe has some version of responsibilities (1), (2), and (3).