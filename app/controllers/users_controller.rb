class UsersController < ApplicationController
	respond_to :json, :html

	def show
		@user = User.find(params[:id])
		render :json => @user.to_json(:only => [:id, :name, :email])
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
      flash[:notice] ||= 'Account created.'
    end
    respond_with @user
  end

  def activate
	  if (@user = User.load_from_activation_token(params[:id]))
	    @user.activate!
	    flash[:notice] ||= 'Your account was successfully activated.'
	  else
	    not_authenticated
	  end
	  respond_with @user, location: account_path(@user.id)
	end

  private

  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
