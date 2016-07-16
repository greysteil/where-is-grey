source 'https://rubygems.org'
ruby '2.3.1'

gem 'sinatra', '~> 1.4.7'       # Web framework
gem 'puma'                      # Web server

gem 'redis-sinatra', '~> 1.4'   # Cache store

gem 'prius', '~> 1.0'           # Environment variable management
gem 'rake', '~> 11.0'           # Task manager

gem 'spot-gps', '~> 0.2.1'      # Client library for SPOT GPS tracker

group :development do
  gem 'rspec', '~> 3.5'         # Testing framework
  gem 'rspec-its'               # Allows `its(:method) { ... }`
  gem 'rack-test'               # Testing Sinatra

  gem 'webmock', '~> 2.1.0'     # Mocking API calls

  gem 'pry'                     # Debugging console

  gem 'dotenv', require: false  # Local environment variables
  gem 'shotgun'                 # Auto-reloading web server
end
