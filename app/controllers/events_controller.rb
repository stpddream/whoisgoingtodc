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
	redirect_to root_path
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

