class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def show
    if signed_in?
      @user = User.find(params[:id])
      @events = @user.events.all
    else 
      redirect_to '/signup'
    end
  end
    
  def index
    if signed_in?
      @users = User.search(params[:search])
    else 
      redirect_to '/signup'  
    end
    
  end
  
  def create
    @user = User.new(user_params)    
    if @user.save
      sign_in @user
      redirect_to @user
    else 
      render 'new'
    end
  end
 
  def feed
    Event.where("user_id = ?", id)
  end
  
  
  private  
  
  def user_params
    params.require(:user).permit!
  end
  
  
end
