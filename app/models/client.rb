class Client < ApplicationRecord
    validates_uniqueness_of :email
end
