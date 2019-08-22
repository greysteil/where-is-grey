source 'https://rubygems.org'
ruby '2.6.2'

gem 'sinatra', '2.0.6'               # Web framework
gem 'puma'                           # Web server

gem 'activerecord', '6.0.0'          # Object-relational mapper
gem 'pg', '~> 1.1.4'                 # PostgreSQL gem
gem 'sinatra-activerecord',
    git: 'https://github.com/greysteil/sinatra-activerecord',
    branch: 'support-rails-6'           # Sinatra setup for AR

gem 'prius', '~> 2.0'                # Environment variable management
gem 'rake', '~> 12.3'                # Task manager

gem 'spot-gps', '~> 0.2.7'           # Client library for SPOT GPS tracker
gem 'exifr', '~> 1.3.6'              # Read image metadata, including GPS data
gem 'google-api-client', '~> 0.30.8' # Pull images from Google Drive
gem 'fog-aws', '~> 0.9.4'            # Push images up to S3

gem 'mini_magick'                    # Image manipulation (re-orienting for S3)

group :development, :test do
  gem 'pry'                          # Debugging console

  gem 'dotenv', require: false       # Local environment variables
  gem 'shotgun'                      # Auto-reloading web server

  gem 'fog-local', '~> 0.6.0'        # Local file storage for Fog
end

group :test do
  gem 'rspec', '~> 3.8'              # Testing framework
  gem 'rspec-its'                    # Allows `its(:method) { ... }`
  gem 'rack-test'                    # Testing Sinatra

  gem 'webmock', '~> 3.6.2'          # Mocking API calls

  gem 'factory_bot'                  # Quickly instantiate models

  gem 'database_cleaner'             # Clean up database after each run
end
