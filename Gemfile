source 'https://rubygems.org'

gem 'rails', '4.2.1'

# Use pg as the database for Active Record
gem 'pg'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'
gem 'bootstrap-sass'
gem 'haml'
gem 'haml-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# form gems
gem 'simple_form', '~> 3.0.0'

gem 'multi-select-rails'
gem 'jquery-validation-rails'

gem 'sorcery'

gem 'thin'

group :test, :development do
  gem 'rspec-rails'
  gem 'annotate', '~> 2.5.0'
  gem 'pry'
  gem 'spring'
  gem 'spring-commands-rspec'
end

group :test, :development, :staging do
  gem 'faker'
  gem 'awesome_print'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
end

group :development do
  gem 'better_errors'
  gem 'quiet_assets'
end

group :test do
  gem 'simplecov', require: false
end

group :production do
  gem 'rails_12factor'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end
