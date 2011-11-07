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
    
# Useful code for the lazy and absentminded

Use to get basic profile info from rails console

    p = Person.find_by_identifier("737428913")
    fb = FbGraph::User.me(p.access_token).fetch
    
Get profile info of a friend 

    p = Person.find_by_identifier("737428913")
    fb = FbGraph::User.fetch("21202456", :access_token => p.access_token)
    
Setup a new MySQL user with all permissions

    GRANT ALL ON partypeeple_production.* TO 'partypeeple'@localhost IDENTIFIED BY 'somepassword';

Generate a app_access_token to do things like create test users

    https://graph.facebook.com/oauth/access_token?client_id=133107960128280&client_secret=f751d36bbfe6e9dd983f2516c040baaf&grant_type=client_credentials

Generate a test user

    https://graph.facebook.com/133107960128280/accounts/test-users?
      installed=true
      &name=FULL_NAME
      &permissions=read_stream,user_about_me,user_activities,user_birthday,user_education_history,user_events,user_groups,user_hometown,user_interests,user_likes,user_photos,user_relationships,user_relationship_details,user_religion_politics,user_work_history,email,offline_access
      &method=post
      &access_token=133107960128280|2QW_NKtcV26UMFCR08O7s-V73f0

    Example: https://graph.facebook.com/133107960128280/accounts/test-users?installed=true&name=Joe%20Blow&permissions=read_stream,user_about_me,user_activities,user_birthday,user_education_history,user_events,user_groups,user_hometown,user_interests,user_likes,user_photos,user_relationships,user_relationship_details,user_religion_politics,user_work_history,email,offline_access&method=post&access_token=133107960128280|2QW_NKtcV26UMFCR08O7s-V73f0

Test Users for Development App

    {
       "id": "100003125681210",
       "access_token": "AAAB5D5yuIxgBAKZAAtJ5OJUMu9nRat7x2Gs1v9eMpRtdQOaGnmncdsBGrPIukTdu3sY2sZBBitPmKZCyTEjsufzc2vUwRMFmRlTSHZAhXAZDZD",
       "login_url": "https://www.facebook.com/platform/test_account_login.php?user_id=100003125681210&n=kdBdSswFA7otufQ",
       "email": "joe_kzyiqim_blow\u0040tfbnw.net",
       "password": "190474533"
    }
    
    {
       "id": "100003108654021",
       "access_token": "AAAB5D5yuIxgBAHR4YWooXukUageZBppdkNpsSZCuFXPNxtFvccZCOvC1nZC1Hb2Yfq3vcQffByJ1x45Kdxv465filOBDEzDlsHthtq1k2AZDZD",
       "login_url": "https://www.facebook.com/platform/test_account_login.php?user_id=100003108654021&n=OcTXZKq75dIphfT",
       "email": "tricia_joqwctw_helfer\u0040tfbnw.net",
       "password": "307156459"
    }
    
    {
       "id": "100003112464442",
       "access_token": "AAAB5D5yuIxgBAO3DCLf6jQt7ng5DFfZCkAwKpyRp8L3BT0vZCyjUFhc9xGZCnShBQU8ykI6vigDX4KDsPhQe3KBVFZBE1idrczpSNb6JugZDZD",
       "login_url": "https://www.facebook.com/platform/test_account_login.php?user_id=100003112464442&n=h7YZexHnhl3ifEb",
       "email": "zooey_yttlbzz_deschanel\u0040tfbnw.net",
       "password": "1053297782"
    }

# To Do:

* Finish conversation starters
* Develop statistics dashboard page 
* Post event mailer
* Add final Help content
* Add final About content
* Add browse by name
* Add ability to skip orietation if user "interested in" is available
* Add rejection content and add to workflow
* Add post party content and develop a way to force users to the page

# Nice To Do

* Add furry profile
* Add e-geaux profile