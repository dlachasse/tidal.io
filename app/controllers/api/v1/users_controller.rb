module Api
	module V1
		class UsersController < ApplicationController
			skip_before_filter :restrict_access, except: [:show]
			respond_to :json, :html

			def show
				@user = User.find(params[:id])
				render :json => @user.to_json(:only => [:id, :name, :email, :api_key])
			end

			def new
				@user = User.new
			end

			def create
				@user = User.new(user_params)
				if @user.save
		      flash[:notice] ||= 'Account created.'
		    end
		    render :json => @user.to_json(:only => [:id, :name, :email])
		  end

		  def activate
			  if (@user = User.load_from_activation_token(params[:id]))
			    @user.activate!
			    @user.login(current_user.email, current_user.password)
			  else
			    not_authenticated
			  end
			  respond_with @user, location: api_user_path(@user.id)
			end

		  private

		  def user_params
		  	params.permit(:name, :email, :password, :password_confirmation)
		  end

		end

	end

end