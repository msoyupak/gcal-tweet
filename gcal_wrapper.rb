require 'google/api_client'
require 'google/api_client/auth/file_storage'


class GCalWrapper

  CREDENTIAL_STORE_FILE = "gcal-oauth2.json"

  def initialize

    @client = Google::APIClient.new(
      :application_name => 'gcal-tweet',
      :version => '1.0.0')

    file_storage = Google::APIClient::FileStorage.new(CREDENTIAL_STORE_FILE)

    if file_storage.authorization.nil?
      @client_secrets = Google::APIClient::ClientSecrets.load
      @client.authorization = client_secrets.to_authorization
      @client.authorization.scope = 'https://www.googleapis.com/auth/calendar'
    else
      @client.authorization = file_storage.authorization
    end

    @calendar = @client.discovered_api('calendar', 'v3')

  end

  def events_in_one_day
    result = @client.execute(
      :api_method => @calendar.events.list,
      :parameters =>
        {
          'calendarId' => calendar_id,
          'timeMax' => format_time(time_end),
          'timeMin' => format_time(time_start)
        },
      :authorization => user_credentials)

    result.data.items.map{ |e| [e.summary, e.start.dateTime.to_s]}
  end

  private

  def calendar_id
    ENV['calendar_id']
  end

  def time_start
    Time.now
  end

  def format_time(time)
    s = time.strftime("%FT%T%z")
  end

  def one_day
    24*60*60
  end

  def time_end
    time_start + one_day
  end

  def user_credentials
    @client.authorization.dup
  end
end
