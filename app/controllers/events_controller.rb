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
        redirect_to "/"
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
       
        where = nil         
        if params[:dest] == 'All'
          where = nil                  
        else
          where = params[:dest]
        end
        
         if params[:who] == 'Public'   
             if where     
               feeds = Event.where(created_at: 1.hour.ago..Time.now, visibility: true, where: where).where.not(user_id: current_user)
             else 
               feeds = Event.where(created_at: 1.hour.ago..Time.now, visibility: true).where.not(user_id: current_user)
             end 
          
         else 
             cur_user_friends = current_user.friendeds.all
             feeds = Event.where(id: nil)
             cur_user_friends.each{ |f|
                 if where
                     Event.where(user_id: f.id, created_at: 1.hour.ago..Time.now, where: where).each do |event|
                         feeds << event
                     end
                 else 
                     Event.where(user_id: f.id, created_at: 1.hour.ago..Time.now).each do |event|
                       feeds << event                
                     end
                 end
             }   
          end
          
          @events = feeds
       
          respond_to do |format|
              format.html { redirect_to 'index' }
              format.js
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

