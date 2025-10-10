source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.4.7'

# Back
gem 'rails', '~> 8.0'
gem 'rails-i18n'
gem 'pg', '~> 1.1'
gem 'puma', '~> 7.0'
gem 'delayed_job_active_record'
gem 'delayed_job_web'
gem 'slack-incoming-webhooks'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'ostruct', '~> 0.6.0'

# Front
gem 'sprockets-rails', '~> 3.5'
gem 'sassc-rails'
gem 'kamifusen'
gem 'jbuilder'
gem 'kaminari'
gem 'kaminari-i18n'
gem 'chartkick'
gem 'groupdate'

group :development, :test do
  gem 'byebug', platforms: [:mri, :windows]
end

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  gem 'spring'
  gem 'annotaterb'
  gem 'figaro'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

gem 'tzinfo-data', platforms: [:windows, :jruby]
