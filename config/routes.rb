Rails.application.routes.draw do
	root 'urls#new'
	
	post '/create', to: 'urls#create'
	get '/:short_url', to: 'urls#redirect'
end