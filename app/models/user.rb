class User < ApplicationRecord
  before_create :set_api_key

  validates_presence_of :email, :password
  validates_uniqueness_of :email, case_sensitive: false
  validates_uniqueness_of :api_key

  has_secure_password

  private

  def set_api_key
    self.api_key = SecureRandom.hex(20)
  end
end