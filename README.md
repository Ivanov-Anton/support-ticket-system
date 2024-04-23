# The Customer Issue/Feature Request storage

Our mission is to provide instruments to handle requests from your customers.

Stack
- Tailwind CSS
- JQuery
- PostgreSQL
- Ruby on Rails

### List of supported features
- create Customer request
- delete Customer request
- leave comments for specific Customer Request (only for admin users)

To create a new Customer request as a Customer you can visit the root path and fill in the form. To manage Customer requests visit the `/admin` path and use the default (admin@example.com) user with the "admin" password.

# Running application locally

## MacOS

1. `bundle install`
2. Install Postgres and configure it to listen 5412 port
3. `bin/rails db:create`
4. `bin/rails db:migrate`
5. `bin/rails server`
6. open http://localhost:3000

# License
The application is released under the MIT License.
