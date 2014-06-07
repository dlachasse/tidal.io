module Api
  module V1
    class FeedsController < ApplicationController
      skip_before_filter :restrict_access, only: [:show]
      before_action :grab_user, only: [:create]
      before_action :validate_feed, only: [:create]
      respond_to :json

      def new
      	@feed = Feed.new
      end

      def index
        @feeds = Feed.all
        render :json => @feeds.to_json
      end

      def show
        @feed = Feed.find(params[:id])
        render :json => @feed.to_json(only: [:id, :name, :url])
      end

      def create
        if @rss.is_a?(Array) && @rss.count > 1
          render :json => @rss.to_json
        else
      	  @feed = Feed.where(url: @rss.first).first_or_create(url: @rss.first)
          subscribe_user
          render :json => @feed
        end
      end

      private

      def feed_params
        params.require(:feed).permit(:url)
      end

      def subscribe_user
        Subscription.create_subscription(@user.id, @feed.id) unless @feed.nil?
      end

      def validate_feed
        @rss = []
        FeedParser.discover_rss(params[:feed][:url]).map { |url| @rss << url }
      end

      def grab_user
        key = strip_api_key(request.headers["Authorization"])
        @user = User.find(request.headers["Authorization"])
      end

      def strip_api_key token
        token.gsub!(/\sToken\stoken=/, '')
      end

    end

  end

end