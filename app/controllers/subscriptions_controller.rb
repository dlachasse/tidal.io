class SubscriptionsController < ApplicationController
	respond_to :json
	def index
		@feeds = User.find(params[:user_id]).subscriptions
		render :json => @feeds.to_json(only: [:feed_id])
	end
end
