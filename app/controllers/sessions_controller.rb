class SessionsController < ApplicationController
  skip_before_filter :require_login, only: [:new, :create]
  respond_to :json, :html

  def new
  	@user = User.new
  end

  def create
  	@user = login(params[:email], params[:password])
    location = @user ? user_path(@user) : login_path
    respond_with @user
  end

  def destroy
  	logout
  end

end