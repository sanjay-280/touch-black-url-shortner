# Touch Black URL Shortener

## Installation

1. Clone the repository:
    ```bash
    git clone
    cd touch-black-url-shortner
    ```

2. Install the required gems:
    ```bash
    bundle install
    ```

3. Create a `.env` file and add the following line:
    ```bash
    TEST_SECRET_KEY='this_is_a_test_token'
    ```

4. Set up the database:
    ```bash
    rails db:migrate
    ```

5. Start the Rails server:
    ```bash
    rails server
    ```

Now, you can access the application at `http://localhost:3000`.
