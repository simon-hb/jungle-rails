# Jungle

A mini e-commerce application built with Rails 4.2 for purposes of learning ruby on the rails. Also rspec, capybara, and poltergeist for testing.

Welcome to my first application built using Ruby! Please play around and purchase some of the exotic items in stock.


## Setup

1. Run `bundle install` to install dependencies
2. Run `bin/rake db:reset` to create, load and seed db
3. Run `bin/rails s -b 0.0.0.0` to start the server
4. Open localhost:3000 and play around on the app!
5. The user & password to access admin pages is Jungle & book

## Stripe Testing

Use Credit Card # 4111 1111 1111 1111 for testing success scenarios.

More information in their docs: <https://stripe.com/docs/testing#cards>

## Dependencies

* Rails 4.2 [Rails Guide](http://guides.rubyonrails.org/v4.2/)
* PostgreSQL 9.x
* Stripe
