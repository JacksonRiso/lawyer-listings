web: bundle exec puma -C config/puma.rb
worker: bundle exec sidekiq -c 5 -v
release: rake db:migrate
