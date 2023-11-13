class Lineitem < ApplicationRecord
  belongs_to :product
  belongs_to :budget
end
