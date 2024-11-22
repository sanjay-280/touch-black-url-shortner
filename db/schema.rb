ActiveRecord::Schema[7.0].define(version: 2024_11_22_130138) do
	
	create_table "urls", force: :cascade do |t|
		t.string "original_url"
		t.string "short_url"
		t.datetime "created_at", null: false
		t.datetime "updated_at", null: false
		t.index ["original_url"], name: "index_urls_on_original_url", unique: true
		t.index ["short_url"], name: "index_urls_on_short_url", unique: true
	end

end
