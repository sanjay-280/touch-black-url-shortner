Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  
	root 'urls#new'
	
	post '/create', to: 'urls#create'
	get 'url/:short_url', to: 'urls#redirect'
end