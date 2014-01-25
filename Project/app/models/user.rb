class User < ActiveRecord::Base
  has_secure_password
  
  before_save { |user| user.email = email.downcase }
  validates :email, presence: true
  validates :password, presence: true, length: { minimum: 6 }
  
  
end
