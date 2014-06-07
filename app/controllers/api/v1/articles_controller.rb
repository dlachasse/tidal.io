module Api
	module V1
		class ArticlesController < ApplicationController
			skip_before_filter :restrict_access
			respond_to :json

		  def index
		  	articles = Feed.find(params[:feed_id]).articles.newest
		  	respond_with articles.batch(params[:count]).start(params[:start])
		  end

		  def show
		  	respond_with Article.find(params[:id])
		  end
		end
	end
end
