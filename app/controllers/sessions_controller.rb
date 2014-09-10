class SessionsController < ApplicationController
  skip_before_filter :restrict_access, only: [:new, :create]
  respond_to :json, :html

  def new
  	@user = User.new
  end

  def create
  	@user = login(params[:email], params[:password])
    location = @user ? api_user_path(@user) : login_path
    respond_with @user, location: location
  end

  def destroy
  	logout
    redirect_to root_path
  end

end