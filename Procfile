web: bundle exec puma -C config/puma.rb
worker: bundle exec rake jobs:work
postdeploy: rails db:migrate
