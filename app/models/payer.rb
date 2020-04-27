class Payer < ApplicationRecord

  FETCH_ATTRIBUTES = ['mobile_number']

  has_many :bills
end
