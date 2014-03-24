class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.column :title, :string
      t.column :fun?, :boolean
    end
  end
end
