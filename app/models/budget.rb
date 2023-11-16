class Budget < ApplicationRecord
  belongs_to :user
  has_many :lineitems
  accepts_nested_attributes_for :lineitems, allow_destroy: true, reject_if: :all_blank

  validates :name, presence: true
  validates :description, presence: true
end
