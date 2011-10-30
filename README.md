# Running Jobs

script/delayed_job can be used to manage a background process which will start working off jobs. Make sure you’ve run `script/generate delayed_job`.

`$ RAILS_ENV=production script/delayed_job start
$ RAILS_ENV=production script/delayed_job stop

# Runs two workers in separate processes.
$ RAILS_ENV=production script/delayed_job -n 2 start
$ RAILS_ENV=production script/delayed_job stop`

Workers can be running on any computer, as long as they have access to the database and their clock is in sync. Keep in mind that each worker will check the database at least every 5 seconds.

You can also invoke rake jobs:work which will start working off jobs. You can cancel the rake task with CTRL-C.