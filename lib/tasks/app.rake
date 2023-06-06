namespace :app do
  desc 'Get database from Scalingo'
  task :db do
    Bundler.with_unbundled_env do
      Figaro.load # Load ENV variables
      # Get a new backup archive from Scalingo
      # PG Addon ID from `scalingo addons` CLI command.
      sh "scalingo --app coop-noesya-diagnostic backups-create --addon #{ENV['PG_ADDON_ID']}"
      sh "scalingo --app coop-noesya-diagnostic backups-download --addon #{ENV['PG_ADDON_ID']} --output db/scalingo-dump.tar.gz"

      sh 'rm -f db/latest.dump' # Remove an old backup file if it exists
      sh 'tar zxvf db/scalingo-dump.tar.gz -C db/' # Extract the new backup archive
      sh 'rm db/scalingo-dump.tar.gz' # Remove the backup archive
      sh 'mv db/*.pgsql db/latest.dump' # Rename the backup file
      sh 'DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rails db:drop'
      sh 'bundle exec rails db:create'
      begin
        sh 'pg_restore --verbose --clean --no-acl --no-owner -h localhost -U postgres -d diagnostic_development db/latest.dump'
      rescue
        'There were some warnings or errors while restoring'
      end
      sh 'rails db:migrate'
      sh 'rails db:seed'
    end
  end
end
