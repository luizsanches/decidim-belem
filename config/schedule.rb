# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
every :day, at: '00:00am' do
  rake "decidim:delete_data_portability_files"
end

every :day, at: '00:05am' do
  rake "decidim:metrics:all"
end

every :day, at: '00:10am' do
  rake "decidim:open_data:export"
end

every :day, at: '00:15am' do
  rake "decidim_meetings:clean_registration_forms"
end

every :day, at: '00:20am' do
  rake "decidim_initiatives:check_published"
end

every :day, at: '00:25am' do
  rake "decidim_initiatives:check_validating"
end

every :day, at: '00:30am' do
  rake "decidim_initiatives:notify_progress"
end
