class UrlsController < ApiController
	before_action :authenticate_api_token, only: [:create]
	
	def new
		@url = Url.new
	end
	
	def create
		@url = Url.create_url(url_params["original_url"])
		if @url[:created]
			render json: { short_url: "#{request.base_url}/#{@url[:short_url]}", message: @url[:message] }
		else
			short_url = @url[:short_url].present? ? "#{request.base_url}/#{@url[:short_url]}" : nil
			render json: { short_url: short_url, message: @url[:message] }
		end
	end
	
	def redirect
		@url = Url.find_by_short_url(params["short_url"])
		if @url
			redirect_to @url, allow_other_host: true
		else
			render plain: "URL not found", status: :not_found
		end
	end
	
	private
	
	def url_params
		params.permit("original_url")
	end

end
