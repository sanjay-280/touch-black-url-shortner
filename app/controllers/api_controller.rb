class ApiController < ApplicationController
	
	skip_before_action :verify_authenticity_token
	
	def authenticate_api_token
		unless token && token == TEST_SECRET_KEY && request.post?
			flash[:notice] = { message: "Unauthorized access to API" }
			head :unauthorized
		end
	end
	
	private
	
	def token
		if request.headers['Authorization'].present?
			return request.headers['Authorization']
		end
		nil
	end
	
end