# frozen_string_literal: true

# config valid for current version and patch releases of Capistrano
lock '~> 3.11.2'

set :application, 'bookapp'
set :repo_url, 'git@github.com:bbbbruno/book_app.git'
set :user, 'deploy'

set :log_level, :debug

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/srv/#{fetch(:application)}"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, 'config/credentials/production.key'

# Default value for linked_dirs is []
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system', 'public/packs', 'node_modules'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

set :deploy_via, :remote_cache

# Defaults to false
# Skip migration if files in db/migrate were not modified
set :conditionally_migrate, true

namespace :safe_deploy_to do
  task :push_config do
    next unless any? :linked_files
    on roles(:app) do
      fetch(:linked_files).each do |file|
        unless test "[ -f #{shared_path.join file} ]"
          execute :mkdir, '-p', shared_path.join(File.dirname(file))
          upload! file, "#{shared_path.join file}"
        end
      end
    end
  end
  after 'safe_deploy_to:ensure', 'safe_deploy_to:push_config'
end

set :rbenv_type, :user
set :rbenv_custom_path, '/home/deploy/.anyenv/envs/rbenv'
set :rbenv_ruby, File.read('.ruby-version').strip
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w[rake gem bundle ruby rails]
set :rbenv_roles, :all

set :default_env, { NODE_ENV: 'production' }

append :linked_dirs, '.bundle'
set :bundle_jobs, 1

append :rbenv_map_bins, 'puma', 'pumactl'
