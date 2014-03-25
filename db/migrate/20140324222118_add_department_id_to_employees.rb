class AddDepartmentIdToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :department_id, :int
  end
end
