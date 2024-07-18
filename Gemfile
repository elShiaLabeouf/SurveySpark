source "https://rubygems.org"

ruby "3.2.0"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "=7.1.2"

# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "propshaft"

# Use sqlite3 as the database for Active Record
gem "sqlite3", "~> 1.4"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"

# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem "jsbundling-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem "cssbundling-rails"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

gem "slim-rails"
gem "draper"

group :development, :test do
  gem "byebug"
  gem "pry-rails"
  gem 'rspec-rails', '~> 6.1.0'
end

group :development do
  gem "web-console"
  gem "pronto", require: false
  gem "pronto-rubocop", require: false
  gem "pronto-scss", require: false
  gem "pronto-slim_lint", require: false
  gem "rubocop", require: false
  gem "rubocop-rails", require: false
end

group :test do
  gem "faker"
  gem "capybara"
  gem "factory_bot"
  gem 'database_cleaner-active_record'
  gem "selenium-webdriver"
  gem "shoulda-matchers"
end
