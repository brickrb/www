require "twitter"

class VersionTweeterJob < Struct.new(:version_id)
  def self.enqueue(version_id)
    Delayed::Job.enqueue(new(version_id))
  end

  def perform
    if ENV["RAILS_ENV"] == 'test'
    else
      @version = Version.find(version_id)
      @version_number = @version.number
      @package_name = @version.package.name
      @package = @version.package
      @package_url = "https://#{ENV["SITE_URL"]}/package/#{@package.name.downcase}"

      client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
        config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
        config.access_token        = ENV["TWITTER_OAUTH_TOKEN"]
        config.access_token_secret = ENV["TWITTER_OAUTH_TOKEN_SECRET"]
      end

      client.update("Version #{@version_number} for #{@package_name} was just released! #{@package_url}")
    end
  end
end
