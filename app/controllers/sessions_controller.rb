class SessionsController < ApplicationController
  respond_to :json, :html

  def new
  	@user = User.new
  end

  def create
  	@user = login(params[:email], params[:password])
    location = @user ? user_path(@user) : new_session_path
    respond_with @user, location: location
  end

  def destroy
  	logout
  end

end