class User < ActiveRecord::Base
  has_secure_password
  
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  has_many :events
  
  validates :email, presence: true
  validates :password, presence: true, length: { minimum: 6 }
  
  
  def self.search(search_token) 
    if search_token
      self.find :all, conditions: ["name like ? ", search_token + "%"]
    else 
      self.find(:all)
    end
  end
  
  
  private
  
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
  
end
