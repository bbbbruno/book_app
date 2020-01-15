# frozen_string_literal: true

namespace :utils do
  task :ls do
    on roles(:app) do
      execute :ls, '-la'
    end
  end
  task :perl_version do
    on roles(:app) do
      execute %i[perl -v]
    end
  end
  task :compile do
    on roles(:app) do
      within '/srv/bookapp/releases/20200114174621' do
        execute '/home/deploy/.anyenv/envs/rbenv/bin/rbenv exec bundle exec rake assets:precompile'
      end
    end
  end
  task :load_remote_environment do
    desc 'Load remote environment'
    on roles(:app, :db, :web) do
      puts execute(:printenv)
    end
  end
  task :create_app_dir do
    fetch(:user) || ask(:user, nil)
    fetch(:application) || ask(:application, nil)
    on roles(:app) do
      user = fetch(:user) || raise('ユーザー名は必須')
      application = fetch(:application) || raise('アプリ名は必須')
      unless test "[ -d /srv/#{application} ]"
        sudo :mkdir, "/srv/#{application}"
      end
      within '/srv' do
        sudo :chown, "#{user}:#{user}", application
        execute :ls, '-l'
      end
    end
  end
end
