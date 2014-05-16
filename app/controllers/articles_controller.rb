class ArticlesController < ApplicationController
	respond_to :json

  def index
  	@articles = Feed.find(params[:feed_id]).articles
  	render :json => @articles.to_json
  end

  def show
  	@article = Article.find(params[:id])
  	render :json => @article.to_json
  end
end
