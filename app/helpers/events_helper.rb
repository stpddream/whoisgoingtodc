module EventsHelper
	def redirect_back_or(default)
	  	redirect_to(session[:return_to] || default)
  		session.delete(:return_to)
	end
end
