module UsersHelper
  
  def gravatar_for(user, smallsize) 
    
    size_param = ""
    if smallsize 
      size_param = 20
    end
    
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "http://www.gravatar.com/avatar/#{gravatar_id}?s=#{size_param}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar img-rounded profile")
  end
end
