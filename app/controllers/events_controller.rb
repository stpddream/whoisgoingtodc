class EventsController < ApplicationController
  before_filter :signed_in_user
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

  private

  def event_params
    params.require(:event).permit(:user_id, :where)
  end
end

