# Facebook Integration
In order to use this app you will need to create a Facebook application at http://developers.facebook.com.  You can enter the application ID and Secret data into rails/config/facebook.yml.

    defaults: &defaults
      app_perms: "user_about_me,user_activities,user_birthday,user_education_history,user_events,user_groups,user_hometown,user_interests,user_likes,user_photos,user_relationships,user_relationship_details,user_religion_politics,user_work_history,email,offline_access"
  
    development: 
      <<: *defaults
      app_id: "xxx"
      app_secret: "xxx"
      administrators: ["xxx", "yyy"]

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

# Tips

If you want Git to ignore your changes to facebook.yml you can use the following command:

    git update-index --assume-unchanged rails/config/facebook.yml
    
# Testing Code

Use to get basic profile info from rails console

    p = Person.find_by_identifier("737428913")
    fb = FbGraph::User.me(p.access_token).fetch

# To Do:
* add delayed_job Capistrano start and stop tasks