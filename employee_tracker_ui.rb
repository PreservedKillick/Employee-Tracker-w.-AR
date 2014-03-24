require 'active_record'
require './lib/employee'
require './lib/department'
require './lib/project'

# database_configurations = YAML::load(File.open('./db/config.yml'))
# development_configuration = database_configurations['development']
# ActiveRecord::Base.establish_connection(development_configuration)
ActiveRecord::Base.establish_connetion(YAML::load(File.open('./db/config.yml'))["development"])

system "clear"

start_menu
  puts "Welcome to the Employee Tracker Menu"
  tracker_menu
end

def tracker_menu
  choice = nil
  until choice == 'X'
    puts "'E' - to List Employees"
    puts "'D' - to List Departments"
    puts "'X' - to Exit"
    choice = gets.chomp.upcase
    case choice
      when 'E'
        employee_menu
      when 'D'
        department_menu
      when 'X'
        "Later!"
      else
        puts "Try again, Foo!"
    end
  end
end

def employee_menu
end

def department_menu
end
