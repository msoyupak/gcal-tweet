require 'twitter_wrapper'
require 'gcal_wrapper'


def check_reminder
  gcal_client = GCalWrapper.new
  twitter_client = TwitterWrapper.new

  gcal_client.events_in_one_day.each { |event|
    summary = event[0]
    summary_suffix = summary.length > 50 ? "..." : ""
    short_summary = summary[0..46] + summary_suffix
    date = event[1]
    event_date = date.strftime(" on %A %b %d")
    event_time = date.strftime(" at %I:%M%p")
    status = "Meeting Reminder: " + short_summary + event_date + event_time
    twitter_client.tweet(status)
  }
end

check_reminder
