module Api
	module V1
		class ArticlesController < ApplicationController
			skip_before_filter :require_login
			respond_to :json

		  def index
		  	respond_with Feed.find(params[:feed_id]).articles
		  end

		  def show
		  	respond_with Article.find(params[:id])
		  end
		end
	end
end
