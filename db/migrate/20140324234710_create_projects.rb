class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.column :called, :string
      t.column :done, :boolean
      t.column :due_date, :datetime

      t.timestamps
    end
  end
end
