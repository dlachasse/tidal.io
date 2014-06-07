module Api
  module V1
    class FeedsController < ApplicationController
      skip_before_filter :restrict_access, only: [:show]
      after_action :subscribe_user, only: [:create]
      before_action :grab_user, only: [:create]
      before_action :validate_feed, only: [:create]
      respond_to :json

      def new
      	@feed = Feed.new
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
        @user = User.find(params[:user_id])
      end

    end

  end

end