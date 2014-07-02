module Api
	module V1
		class OpmlController < ApplicationController
		  def create
		  	current_user = User.find(1)
		  	File.open("public/opml/#{current_user.id}.xml", 'wb') { |f| f.write(params[:file].read) }
		  	params[:file].close
		  	OpmlParserWorker.perform_async(current_user.id)
		  	render :json => "#{params[:file].path}, #{current_user.email}".to_json
		  end
		end
	end
end