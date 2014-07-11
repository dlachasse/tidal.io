class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/tidal.v1' }

  # before_filter :restrict_access
  before_filter :set_headers # use this only for testing, adds additional query

  def restrict_access
	  authenticate_or_request_with_http_token do |token, options|
	    User.exists?(api_key: token)
	  end
	end

	def set_headers
		if current_user
	    request.headers['Accept'] = 'application/tidal.v1'
	    request.headers['Authorization'] = "Token token=#{current_user.api_key}"
	  end
	end
end
