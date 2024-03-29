source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.7'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'
#
# Notifications
gem 'sidekiq'

# cron job for creating notifications jobs
gem 'whenever', '~> 1.0', require: false

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

gem 'image_processing', '~> 1.12', '>= 1.12.2'

gem 'money-rails', '~>1.12'

gem 'elasticsearch-model', github: 'elastic/elasticsearch-rails', branch: 'main'
gem 'elasticsearch-rails', github: 'elastic/elasticsearch-rails', branch: 'main'

group :development, :test do
  gem 'pry', '~> 0.14.1'
  gem 'pry-nav'
  gem 'pry-remote'
  gem 'database_cleaner-active_record'

  gem 'factory_bot_rails'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  gem 'rspec-rails', '~> 6.0.0'
  gem "solargraph", "~> 0.44.2" 
  gem 'solargraph-rails', '~> 1.0', '>= 1.0.1'
end

gem "net-smtp", "~> 0.3.3"

gem "pg", "~> 1.4"


gem "rack-cors", "~> 1.1.1"

gem "devise", "~> 4.8"

gem "devise_token_auth", "~> 1.2"

gem "omniauth", "~> 2.1"

gem 'pundit', '~> 2.2'

gem "figaro"

gem "blueprinter", "~> 0.25.3"

gem 'aasm', '~> 5.5'
