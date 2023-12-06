class Lineitem < ApplicationRecord
  belongs_to :product
  belongs_to :budget

  validates :quantity, presence: true, numericality: { greater_than: 0, message: "debe ser mayor a cero" }
end
