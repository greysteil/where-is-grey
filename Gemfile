source 'https://rubygems.org'
ruby '3.2.1'

gem 'sinatra', '4.1.1'               # Web framework
gem 'puma'                           # Web server

gem 'activerecord', '8.0.0.1'        # Object-relational mapper
gem 'pg', '~> 1.5.9'                 # PostgreSQL gem
gem 'sinatra-activerecord', '2.0.28' # Sinatra setup for AR

gem 'prius', '~> 6.0'                # Environment variable management
gem 'rake', '~> 13.2'                # Task manager
gem 'rackup', '~> 2.2'               # CLI for running Rack-compatible applications

gem 'spot-gps', '~> 0.3.1'           # Client library for SPOT GPS tracker
gem 'exifr', '~> 1.4.0'              # Read image metadata, including GPS data
gem 'google-api-client', '~> 0.53.0' # Pull images from Google Drive
gem 'fog-aws', '~> 0.9.4'            # Push images up to S3

gem 'mini_magick'                    # Image manipulation (re-orienting for S3)

group :development, :test do
  gem 'pry'                          # Debugging console

  gem 'dotenv', require: false       # Local environment variables
  gem 'shotgun'                      # Auto-reloading web server

  gem 'fog-local', '~> 0.8.0'        # Local file storage for Fog
end

group :test do
  gem 'rspec', '~> 3.13'             # Testing framework
  gem 'rspec-its'                    # Allows `its(:method) { ... }`
  gem 'rack-test'                    # Testing Sinatra

  gem 'webmock', '~> 3.24.0'         # Mocking API calls

  gem 'factory_bot'                  # Quickly instantiate models

  gem 'database_cleaner'             # Clean up database after each run
end
