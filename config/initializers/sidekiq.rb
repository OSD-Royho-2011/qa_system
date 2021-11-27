require 'sidekiq/web'

module Sidekiq
  module WebHelpers
    def locale
      'en'
    end
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://127.0.0.1:6379/0"}
end

Sidekiq.configure_server do |config|
  config.redis = { url: "redis://127.0.0.1:6379/0"}
  # schedule_file = "config/schedule.yml"
  # if File.exist?(schedule_file)
  #   Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
  # end
end

