module SessionsHelper
  
  def sign_in(user) 
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
    puts "haha" + user.nil?.to_s
  end
  
  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end
  
  def signed_in?
    !(self.current_user.nil?)
  end
  
  
  
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end
  
  def current_user?(user)
    user == current_user
  end
  
  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "Please sign in."
    end
  end

end
