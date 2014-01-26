class FriendsController < ApplicationController
  def create
    @user = User.find(params[:friend][:friended_id])
    current_user.friend!(@user)
    
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end

  end

  def destroy
  end
end
