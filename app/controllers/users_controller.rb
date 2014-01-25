class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
  end
    
  def index
    @users = User.search(params[:search])
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
  
  
  
  private  
  
  def user_params
    params.require(:user).permit!
  end
  
  
end
