class SubscriptionsController < ApplicationController
	respond_to :json

	def index
		respond_with User.find(params[:user_id]).subscriptions
	end
end
