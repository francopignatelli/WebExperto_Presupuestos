class Budget < ApplicationRecord
  attr_accessor :selected_products
  belongs_to :user
  has_many :lineitems
  # Se podria agregar has_many :lineitems, dependet: :destroy
  has_many :products, through: :lineitems
  accepts_nested_attributes_for :lineitems, allow_destroy: true, reject_if: :all_blank

  validates :name, presence: true
  validates :description, presence: true

  accepts_nested_attributes_for :lineitems, allow_destroy: true, reject_if: :all_blank
end
