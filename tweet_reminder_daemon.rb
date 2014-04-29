require 'twitter_wrapper'
require 'gcal_wrapper'

class TweetReminderDaemon

  POLL_TIME = 6*60*60

  def initialize
    @events = []
  end

  def check_reminder
    gcal_client = GCalWrapper.new
    twitter_client = TwitterWrapper.new

    puts "check reminder"
    gcal_client.events_in_one_day.select{|e| !@events.include?(e[2]) }.each { |event|

      summary = event[0]
      date = event[1] + Time.zone_offset("PDT")
      event_id = event[2]

      puts "event found: #{summary} #{date} #{id}"
      summary_suffix = summary.length > 50 ? "..." : ""
      short_summary = summary[0..46] + summary_suffix

      event_date = date.strftime(" on %A %b %d")
      event_time = date.strftime(" at %I:%M%p")
      status = "Meeting Reminder: " + short_summary + event_date + event_time

      @events << event_id

      twitter_client.tweet(status)
    }
  end

  def execute
    while true do
      puts "Checking calendar reminders"
      check_reminder
      puts "#{@events.count} events tweeted"
      sleep(POLL_TIME)
    end
  end

end

TweetReminderDaemon.new.execute
