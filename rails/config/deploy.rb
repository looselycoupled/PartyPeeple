# require "bundler/capistrano"

set :application, "partypeeple"

set :scm, :git
set :repository,  "git@github.com:looselycoupled/PartyPeeple.git"

set :user, "root"
set :environment, "production"
set :deploy_to, "/var/apps/#{application}"
set :owners, "www-data:www-data"

role :web, "50.57.42.23"                          # Your HTTP server, Apache/etc
role :app, "50.57.42.23"                          # This may be the same as your `Web` server
role :db,  "50.57.42.23", :primary => true # This is where Rails migrations will run


ssh_options[:forward_agent] = true






namespace :deploy do 


  desc <<-DESC
      Updates the symlink to the most recently deployed version. Capistrano works \
      by putting each new release of your application in its own directory. When \
      you deploy a new version, this task's job is to update the `current' symlink \
      to point at the new version. You will rarely need to call this task \
      directly; instead, use the `deploy' task (which performs a complete \
      deploy, including `restart') or the 'update' task (which does everything \
      except `restart').
  DESC
  task :symlink, :except => { :no_release => true } do
    on_rollback do
      if previous_release
        run "rm -f #{current_path}; ln -s #{previous_release}/rails #{current_path}; true"
      else
        logger.important "no previous release to rollback to, rollback of symlink skipped"
      end
    end

    run "rm -f #{current_path} && ln -s #{latest_release}/rails #{current_path}"
  end


  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end





  desc <<-DESC
      [internal] Touches up the released code. This is called by update_code \
      after the basic deploy finishes. It assumes a Rails project was deployed, \
      so if you are deploying something else, you may want to override this \
      task with your own environment's requirements.

      This task will make the release group-writable (if the :group_writable \
      variable is set to true, which is the default). It will then set up \
      symlinks to the shared directory for the log, system, and tmp/pids \
      directories, and will lastly touch all assets in public/images, \
      public/stylesheets, and public/javascripts so that the times are \
      consistent (so that asset timestamping works).  This touch process \
      is only carried out if the :normalize_asset_timestamps variable is \
      set to true, which is the default The asset directories can be overridden \
      using the :public_children variable.
    DESC
    task :finalize_update, :except => { :no_release => true } do
      run "chmod -R g+w #{latest_release}" if fetch(:group_writable, true)
      run "chown -R www-data:www-data #{latest_release}" 

      # mkdir -p is making sure that the directories are there for some SCM's that don't
      # save empty folders
      run <<-CMD
        rm -rf #{latest_release}/log #{latest_release}/rails/public/system #{latest_release}/tmp/pids &&
        mkdir -p #{latest_release}/rails/public &&
        mkdir -p #{latest_release}/rails/tmp &&
        ln -s #{shared_path}/log #{latest_release}/rails/log &&
        ln -s #{shared_path}/system #{latest_release}/rails/public/system &&
        ln -s #{shared_path}/pids #{latest_release}/rails/tmp/pids
      CMD

      if fetch(:normalize_asset_timestamps, true)
        stamp = Time.now.utc.strftime("%Y%m%d%H%M.%S")
        asset_paths = fetch(:public_children, %w(images stylesheets javascripts)).map { |p| "#{latest_release}/rails/public/#{p}" }.join(" ")
        run "find #{asset_paths} -exec touch -t #{stamp} {} ';'; true", :env => { "TZ" => "UTC" }
      end
    end



end

