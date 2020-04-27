class Receipt < ApplicationRecord
  belongs_to :external_service_provider
  belongs_to :bill
end
