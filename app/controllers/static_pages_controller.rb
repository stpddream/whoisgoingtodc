class StaticPagesController < ApplicationController
  def home
    
    
	if signed_in?
		@event = current_user.events.build if signed_in?
  	@public_feed_items = Event.where(created_at: 1.hour.ago..Time.now, visibility: true).where.not(user_id: current_user.id)
		@cur_user_friend = current_user.friendeds.all
		@friend_feed_items = Event.where(id:nil)
		@cur_user_friend.each{|friend| @friend_feed_items << Event.where(user_id: friend_id, created_at: 1.hour.ago..Time.now) }
	else 
	  @user = User.new
	end
  end
end
