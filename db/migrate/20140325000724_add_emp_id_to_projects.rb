class AddEmpIdToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :employee_id, :int
  end
end
