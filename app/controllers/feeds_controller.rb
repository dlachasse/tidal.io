class FeedsController < ApplicationController
  respond_to :json, :html

  def new
  	@feed = Feed.new
  end

  def show
    @feed = Feed.find(params[:id])
    render :json => @feed.to_json
  end

  def create
  	@feed = Feed.where(url: params[:feed][:url]).first_or_create(url: params[:feed][:url])
    location = @feed.save ? feed_path(@feed) : new_feed_path
    respond_with @feed, location: location
  end

  def destroy
  	Feed.find(params[:id]).destroy
  end

  private

  def feed_params
    params.require(:feed).permit(:url)
  end

end