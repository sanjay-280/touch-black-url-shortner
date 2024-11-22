Rails.application.config.middleware.insert_before 0, Rack::Cors do
	allow do
		origins '*' # Use '*' for all origins or specify trusted origins like 'http://localhost:3000'
		
		resource '*',
		         headers: :any,
		         methods: [:get, :post, :put, :patch, :delete, :options, :head],
		         expose: ['Authorization'] # Include headers if needed for authentication
	end
end
