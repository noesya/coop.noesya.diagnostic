source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '4.0.5'

# Back
gem 'bootsnap', require: false
gem 'delayed_job_active_record'
gem 'delayed_job_web'
gem "net-http", "~> 0.9.1"
gem 'rails', '~> 8.1.0'
gem 'rails-i18n'
gem 'pg', '~> 1.6'
gem 'puma', '~> 8.0'
gem "ruby-vips", "~> 2.3"
gem 'slack-incoming-webhooks'

# Front
gem 'chartkick'
gem 'groupdate'
gem 'jbuilder'
gem 'kaminari'
gem 'kaminari-i18n'
gem 'sassc-rails'
gem 'sprockets-rails', '~> 3.5'

group :development, :test do
  gem 'byebug', platforms: [:mri, :windows]
end

group :development do
  gem 'annotaterb'
  gem 'figaro'
  gem 'listen', '~> 3.10'
  gem 'spring'
  gem 'rack-mini-profiler', '~> 4.0'
  gem 'web-console', '~> 4.3'
end

group :test do
  gem 'capybara', '~> 3.40'
  gem 'webdrivers'
end

gem 'tzinfo-data', platforms: [:windows, :jruby]
