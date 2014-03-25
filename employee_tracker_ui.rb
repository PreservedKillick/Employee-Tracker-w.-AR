require 'active_record'
require './lib/employee'
require './lib/department'
require './lib/project'
require 'pry'
require 'shoulda-matchers'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)
# ActiveRecord::Base.establish_connetion(YAML::load(File.open('./db/config.yml'))["development"])

system "clear"

def start_menu
  puts "Welcome to the Employee Tracker Menu"
  tracker_menu
end

def tracker_menu
  choice = nil
  until choice == 'X'
    puts "'D' - to Add, List, and Edit department records"
    puts "'E' - to Add, List, and Edit employee records"
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
  system "clear"
  puts "What would you like to do?"
  puts "\t'A' to add an employee"
  puts "\t'L' to see all your employees"
  puts "\t'E' to edit an employee entry"
  puts "\t'M' to go back to the main menu"
  puts "\t'X' to exit the program"
  emp_input = gets.chomp.upcase
  case emp_input
  when 'A'
    add_employee
  when 'L'
    list_employees
  when 'E'
    edit_employees
  when 'M'
    tracker_menu
  when 'X'
    puts "Later!"
  else
    puts "Not a valid selection. Please try again"
  end
end

def add_employee
  system "clear"
  puts "Name of Employee?"
  name = gets.chomp.split.each{|i| i.capitalize!}.join(' ')
  puts "\n\nIs Employee nice? 'Y' for Yes or 'N' for No"
  nice = gets.chomp.downcase
  nice = (nice == 'y')? true : false;
  title = ''
  until title != ''
    puts "\n\nNow add Employee to a Department"
    puts_all_departments
    title = gets.chomp.split.each{|i| i.capitalize!}.join(' ')
  end
  department = Department.find_by title: title
  employee = Employee.new({:name => name, :nice? => nice, :department_id => department.id})
  employee.save
  puts "\n\n'#{name}' has been saved to Employee List.\n\n"
end

def list_employees
  system "clear"
  puts "Here are all of the employees currently in the database:"
  puts_all_employees
end

def edit_employees
  system "clear"
  puts_all_employees
  puts "\nWhich employee to edit\n"
  name = gets.chomp.split.each{|i| i.capitalize!}.join(' ')
  puts "\n\n#{name} is what you want to edit"
  # Find the person
  employee = Employee.where({:name => name}).first
  puts "\nWhat is this employees new name? Leave blank to leave the same."
  new_name = caps_each_word(gets.chomp)
  puts "\nIs #{new_name} nice? 'Y' for Yes, 'N' for No"
  new_name = (new_name != '')? new_name : name;
  new_nice = gets.chomp.upcase
  new_nice = (new_nice == 'Y')? true : false;
  current_department = Department.find_by id: employee.department_id
  puts "\n#{current_department.title} is the employee's current department"
  puts_all_departments
  puts "\nChoose the new department or leave blank to keep the same"
  new_title = gets.chomp.split.each{|i| i.capitalize!}.join(' ')
  new_title = (new_title != '')? new_title : current_department.title

  if new_title != current_department.title
    new_department = Department.find_by title: title
  else
    new_department = current_department
  end

  employee.update({:name => new_name, :nice? => new_nice, :department_id => new_department.id})
  puts "\n\n#{new_name} has been updated."
end

def department_menu
  system "clear"
  puts "What would you like to do?"
  puts "\t'A' to add an department"
  puts "\t'L' to see all your departments"
  puts "\t'E' to edit an department entry"
  puts "\t'M' to go back to the main menu"
  puts "\t'X' to exit the program"
  emp_input = gets.chomp.upcase
  case emp_input
  when 'A'
    add_department
  when 'L'
    list_departments
  when 'E'
    edit_departments
  when 'M'
    tracker_menu
  when 'X'
    puts "Later!"
  else
    puts "Not a valid selection. Please try again"
  end
end

def add_department
  system "clear"
  puts "Title of Department?"
  title = gets.chomp.split.each{|i| i.capitalize!}.join(' ')
  puts "Is Department fun? 'Y' for Yes or 'N' for No"
  nice = gets.chomp.downcase
  fun = (fun == 'y')? true : false;
  department = Department.new({:title => title, :fun? => fun})
  department.save
  puts "'#{title}' has been saved to Employee List"
end

def list_departments
  system "clear"
  puts "Here are all of the departments currently in the database:"
  puts_all_departments
  puts "\n\nWould you like to see all the employees in a department?  If so, enter the name of the department you would like to see:\n"
  dpt_input = gets.chomp.split.each{|i| i.capitalize!}.join(' ')
  binding.pry
  view_dpt = Department.find_by title: dpt_input
  puts view_dpt.employees.first.name
  puts "\n\n"
end

def edit_departments
  system "clear"
  puts_all_departments
  puts "\nWhich department to edit"
  title = gets.chomp.capitalize
  puts "#{title} is what you want to edit"
  puts "What is this department's new name? Leave blank to leave the same."
  new_title = gets.chomp.split.each{|i| i.capitalize!}.join(' ')
  new_title = (new_title != '')? new_title : title;
  puts "Is #{new_title} fun? 'Y' for Yes, 'N' for No"
  new_fun = gets.chomp.upcase
  new_fun = (new_fun == 'Y')? true : false;
  department = Department.where({:title => title}).first
  department.update({:title => new_title, :fun? => new_fun})
  puts "#{new_title} has been updated."
end



############################
# ** Helper methods below **
############################

def puts_all_employees
  Employee.all.each do |employee|
    puts "#{employee.name}"
    puts "\tfrom #{employee.department.title}"
    puts "\tis nice? #{employee.nice?}\n"
  end
end

def puts_all_departments
  Department.all.each do |department|
    puts "#{department.title}"
    puts "\tis a fun department? #{department.fun?}\n"
  end
end

def caps_each_word(str)
  str.split.each{|i| i.capitalize!}.join(' ')
end

start_menu
