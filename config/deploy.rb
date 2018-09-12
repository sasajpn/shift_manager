# config valid only for current version of Capistrano
lock '3.6.1'

set :application, 'shift_manager'
set :repo_url, 'git@github.com:sasajpn/shift_manager.git'

set :branch, ENV['BRANCH'] || 'master'

set :deploy_to, '/var/www/shift_manager'

set :linked_files, %w{.env config/secrets.yml config/database.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets public/uploads}

set :keep_releases, 5

set :rbenv_ruby, '2.4.0'
set :rbenv_type, :system

set :log_level, :error

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'unicorn:restart'
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end

  after :publishing, :restart
end
