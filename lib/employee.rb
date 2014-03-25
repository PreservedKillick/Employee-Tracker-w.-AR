class Employee < ActiveRecord::Base
  belongs_to(:department)
  has_many(:projects)
end
