class FeedsController < ApplicationController
  after_action :subscribe_user, only: [:create]
  before_action :validate_feed, only: [:create]
  respond_to :json, :html

  def new
  	@feed = Feed.new
  end

  def show
    @feed = Feed.find(params[:id])
    render :json => @feed.to_json(only: [:id, :name, :url])
  end

  def create
    if @rss.size > 1 || @rss.empty?
      render :json => @rss.to_json
    else
  	  @feed = Feed.where(url: @rss.first).first_or_create(url: @rss.first)
      location = @feed.save ? feed_path(@feed) : new_feed_path
      respond_with @feed, location: location
    end
  end

  def destroy
  	Feed.find(params[:id]).destroy
  end

  private

  def feed_params
    params.require(:feed).permit(:url)
  end

  def subscribe_user
    if @feed
      Subscription.create!(feed_id: @feed.id, user_id: session[:user_id])
    end
  end

  def validate_feed
    @rss = FeedParser.discover_rss(params[:feed][:url])
  end

end