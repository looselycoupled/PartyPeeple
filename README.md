# Facebook Integration
In order to use this app you will need to create a Facebook application at http://developers.facebook.com.  Within the application_controller you will need to add your own app_id and app_secret to communicate with Facebook's Open Graph API.

# Puppet
N/A

# Running Jobs

script/delayed_job can be used to manage a background process which will start working off jobs. Make sure you’ve run `script/generate delayed_job`.

    $ RAILS_ENV=production script/delayed_job start
    $ RAILS_ENV=production script/delayed_job stop

    # Runs two workers in separate processes.
    $ RAILS_ENV=production script/delayed_job -n 2 start
    $ RAILS_ENV=production script/delayed_job stop

Workers can be running on any computer, as long as they have access to the database and their clock is in sync. Keep in mind that each worker will check the database at least every 5 seconds.

You can also invoke rake jobs:work which will start working off jobs. You can cancel the rake task with CTRL-C.

# Capistrano

This application include a deploy.rb file for Capistrano deployment.  

To Do:
* add delayed_job start and stop tasks

# Testing Code

Use to get basic profile info from rails console

p = Person.find_by_identifier("737428913")
fb = FbGraph::User.me(p.access_token).fetch
