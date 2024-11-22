require 'rails_helper'

RSpec.describe UrlsController, type: :controller do
	before do
		allow_any_instance_of(UrlsController).to receive(:authenticate_api_token).and_return(true)
	end
	
	describe "GET #new" do
		it "returns a success response" do
			get :new
			expect(response).to be_successful
		end
	end
	
	describe "POST #create" do
		context "when the URL is valid" do
			let(:valid_url) { "https://example.com" }
			let(:auth_header) { { "Authorization" => "this_is_a_test_token" } }
			it "creates a new URL and returns a short URL" do
				request.headers.merge!(auth_header)
				post :create, params: { original_url: valid_url }
				expect(response).to have_http_status(:ok)
				json_response = JSON.parse(response.body)
				expect(json_response["message"]).to eq("Short URL created successfully")
				expect(json_response["short_url"]).to include("http://test.host/")
			end
		end
		
		context "when the URL is invalid" do
			let(:invalid_url) { "invalid_url" }
			it "returns an error message" do
				post :create, params: { original_url: invalid_url }
				expect(response).to have_http_status(:ok)
				json_response = JSON.parse(response.body)
				expect(json_response["message"]).to eq("Invalid URL")
			end
		end
		
		context "when the URL already exists" do
			let(:existing_url) { "https://example.com" }
			before do
				Url.create!(original_url: existing_url, short_url: "abc123")
			end
			
			it "returns the existing short URL" do
				post :create, params: { original_url: existing_url }
				expect(response).to have_http_status(:ok)
				json_response = JSON.parse(response.body)
				expect(json_response["message"]).to eq("Short URL already exists")
				expect(json_response["short_url"]).to eq("http://test.host/abc123")
			end
		end
	end
	
	describe "GET #redirect" do
		context "when the short URL exists" do
			let!(:url) { Url.create!(original_url: "https://example.com", short_url: "abc123") }
			it "redirects to the original URL" do
				get :redirect, params: { short_url: "abc123" }
				expect(response).to redirect_to("https://example.com")
			end
		end
		
		context "when the short URL does not exist" do
			it "returns a not found response" do
				get :redirect, params: { short_url: "nonexistent" }
				expect(response).to have_http_status(:not_found)
				expect(response.body).to eq("URL not found")
			end
		end
	end
end
