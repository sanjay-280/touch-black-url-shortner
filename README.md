git clone
cd touch-black-url-shortner
bundle install
Create .env and add the following line:
TEST_SECRET_KEY='this_is_a_test_token'
rails db:migrate
rails server
