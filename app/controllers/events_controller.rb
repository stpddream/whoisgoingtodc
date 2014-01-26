class EventsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user, only: :destroy
  
  def new
    @event = Event.new
  end

  def show
    @event = Event.find(params[:id])
  end

  def create
    @event = Event.new(event_params)
    
    if @event.save
	      flash[:success] = "Event created!"
        redirect_to @event.user
    else
        render 'new'
    end
  end

  def destroy
 	@event.destroy
	redirect_to :back
  end

  
  def index
    if signed_in?
        if params[:who] == 'Public'
            feeds = Event.where(created_at: 1.hour.ago..Time.now, visibility: true).where.not(user_id: current_user)
        else 
            cur_user_friends = current_user.friendeds.all
            feeds = Event.where(id: nil)
            cur_user_friends.each{|f|
                Event.where(user_id: f.id, created_at: 1.hour.ago..Time.now).each do |event|
                feeds << event
                end
            }
        end
                                                                                            
        if params[:dest] == 'All'
            @events = feeds
        elsif params[:dest] == 'Haffner'
            @events = feeds.where(where: 'Haffner')
        elsif params[:dest] == 'Erdman'
            @events = feeds.where(where: 'Erdman')
        elsif params[:dest] == 'Dining Center'
            @events = feeds.where(where: 'Dining Center')
        end
    end
  end
  
  
  private

  def event_params
    params.require(:event).permit(:user_id, :where, :visibility)
  end

  def correct_user
	@event = current_user.events.find_by_id(params[:id])
	redirect_to root_path if @event.nil?
  end
end

