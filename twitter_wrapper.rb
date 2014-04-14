require 'rubygems'
require 'twitter'

class TwitterWrapper

  def initialize
    @api_key = ENV['twitter_api_key']
    @api_secret = ENV['twitter_api_secret']
    @access_token = ENV['twitter_access_token']
    @access_token_secret = ENV['twitter_access_token_secret']

    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = @api_key
      config.consumer_secret     = @api_secret
      config.access_token        = @access_token
      config.access_token_secret = @access_token_secret
    end
  end

  def tweet(status)
    @client.update(status)
  end
end
