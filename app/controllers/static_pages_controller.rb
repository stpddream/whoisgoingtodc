class StaticPagesController < ApplicationController
  def home
	if signed_in?
		@event = current_user.events.build if signed_in?
  		@feed_items = Event.where(created_at: 1.hour.ago..Time.now)
  else 
    @user = User.new
	end
  end
end
