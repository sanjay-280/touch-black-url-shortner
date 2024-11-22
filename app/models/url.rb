class Url < ApplicationRecord
	
	scope :by_short_url, ->(short_url) { where(short_url: short_url) }
	scope :by_original_url, ->(original_url) { where(original_url: original_url) }
	
	validates :original_url, presence: true, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])
	validates :short_url, presence: true, uniqueness: true
	
	class << self
		
		def create_url original_url
			url = fetch_by_original_url(original_url)
			if url.present?
				{ short_url: url.short_url, created: false, message: "Short URL already exists" }
			else
				begin
					url = create!(original_url: original_url, short_url: generate_short_url)
					{ short_url: url.short_url, created: true, message: "Short URL created successfully" }
				rescue ActiveRecord::RecordInvalid
					{ short_url: nil, message: "Invalid URL" }
				end
			end
		end
		
		def find_by_short_url short_url
			url = by_short_url(short_url).first
			return if url.nil?
			url.original_url
		end
		
		private
		
		def fetch_by_original_url url
			by_original_url(url).first
		end
		
		def generate_short_url
			loop do
				short_url = SecureRandom.alphanumeric(6)
				break short_url unless Url.exists?(short_url: short_url)
			end
		end
		
	end
	
end
