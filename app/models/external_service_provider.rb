class ExternalServiceProvider < ApplicationRecord

  before_create :generate_auth_id
  before_create :generate_auth_secret

  def regenerate_auth_secret!
    generate_auth_secret
    save!
  end

  private
  def generate_auth_id
    self.auth_id = SecureRandom.hex(16)
  end

  def generate_auth_secret
    self.auth_secret = SecureRandom.hex(16)
  end
end
