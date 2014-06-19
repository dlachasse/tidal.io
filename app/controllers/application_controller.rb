class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/tidal.v1' }
  # before_filter :restrict_access

  def restrict_access
	  authenticate_or_request_with_http_token do |token, options|
	    User.exists?(api_key: token)
	  end
	end
end
