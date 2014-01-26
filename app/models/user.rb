class User < ActiveRecord::Base
  has_secure_password
  
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
  
  validates :email, presence: true
  validates :password, presence: true, length: { minimum: 6 }
  
  has_many :friends, foreign_key: "friender_id", dependent: :destroy
  
  has_many :friendeds, through: :friends
  
  def friend?(another_user)
    self.friends.find_by_friended_id(another_user.id)
  end
  
  def friend!(another_user)
    if friend?(another_user)
      nil
    else
       self.friends.create!(friended_id: another_user.id)
       another_user.friends.create!(friended_id: self.id)      
    end

  end
  
  def unfriend!(another_user)
    friends.find_by_friended_id(another_user.id).destroy
    another_user.find_by_friended_id(self.id).destroy
  end
  
  
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
