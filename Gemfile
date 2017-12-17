source 'https://rubygems.org'
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'coffee-rails', '~> 4.2'
gem 'devise'
gem 'inky-rb', require: 'inky'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'material_icons'
gem 'materialize-sass'
gem 'pg', '~> 0.18'
gem 'premailer-rails'
gem 'puma', '~> 3.0'
gem 'rails', '~> 5.0.1'
gem 'redis'
gem 'sass-rails', '~> 5.0'
gem 'sidekiq'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'validates_email_format_of'

group :test do
  gem 'factory_girl_rails'
  gem 'ffaker'
end

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'capybara'
  gem 'rails-controller-testing'
  gem 'rspec-rails', '~> 3.5'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
