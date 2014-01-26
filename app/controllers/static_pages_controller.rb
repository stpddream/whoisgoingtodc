class StaticPagesController < ApplicationController
  
  def home
    
    
	if signed_in?
		@event = current_user.events.build if signed_in?
      	@public_feed_items = Event.where(created_at: 1.hour.ago..Time.now, visibility: true).where.not(user_id: current_user.id)
		@cur_user_friend = current_user.friendeds.all
		@friend_feed_items = Event.where(id:nil)
		@cur_user_friend.each { |friend| 
		  Event.where(user_id: friend.id, created_at: 1.hour.ago..Time.now).each do |event|
		    @friend_feed_items << event		    
		    end 
		}
        @erdman_feed_items = @public_feed_items.where(where: "Erdman")
        @haffner_feed_items = @public_feed_items.where(where: "Haffner")
        @dc_feed_items = @public_feed_items.where(where: "Dining Center")
        
        
	else 
	  @user = User.new
	end

  end
end
