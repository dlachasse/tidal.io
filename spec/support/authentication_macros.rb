module AuthenticationHelper
	def preset_authenticated_request(user)
		request.env['HTTP_ACCEPT'] = 'application/tidal.v1'
		request.env['HTTP_AUTHORIZATION'] = "Token token=#{user.api_key}"
	end

end