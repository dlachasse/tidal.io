module Api
	module V1
		class SubscriptionsController < ApplicationController
			respond_to :json

			def index
				subscriptions = User.find(params[:user_id]).subscriptions.pluck(:feed_id)
				respond_with Article.where(feed_id: subscriptions).batch(params[:count]).start(params[:start])
			end
		end

	end

end
