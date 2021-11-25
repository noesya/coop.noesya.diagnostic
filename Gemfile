source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.3'

# Back
gem 'rails', '~> 6.1.4', '>= 6.1.4.1'
gem 'rails-i18n'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'delayed_job_active_record'
gem 'delayed_job_web'
gem 'slack-incoming-webhooks'
gem 'bootsnap', '>= 1.4.4', require: false

# Front
gem 'sassc-rails'
gem 'kamifusen'
gem 'jbuilder'
gem 'kaminari'
gem 'bootstrap5-kaminari-views'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  gem 'spring'
  gem 'annotate'
  gem 'figaro'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
