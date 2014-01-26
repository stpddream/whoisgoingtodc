class User < ActiveRecord::Base
  has_secure_password
  
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
  
  validates :email, presence: true
  validates :password, presence: true, length: { minimum: 6 }
  
  private
  
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
  
end
