module Api
  module V1
    class FeedsController < ApplicationController
      skip_before_filter :restrict_access, only: [:show]
      before_action :grab_user, only: [:create]
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
        @feed = FeedParser.validate_passed_url(params[:feed_url])
        subscribe_user if @feed.is_a? Feed
        render :json => @feed
      end

      private

      def feed_params
        params.permit(:feed_url)
      end

      def subscribe_user
        Subscription.create_subscription(@user.id, @feed.id) unless @feed.nil?
      end

      def grab_user
        key = strip_api_key(request.headers["Authorization"])
        @user = User.find_by(api_key: request.headers["Authorization"])
      end

      def strip_api_key token
        token.gsub!(/Token\stoken=/, '')
      end

    end

  end

end