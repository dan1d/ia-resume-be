require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module IaResumeBe
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.log_tags  = [:subdomain, :uuid]
    config.logger    = ActiveSupport::TaggedLogging.new(logger)

    config.active_job.queue_adapter = :sidekiq

    config.action_cable.disable_request_forgery_protection = true
    # config.action_cable.url = "/cable"
    config.hosts << "api.ia-resume.com"
    config.hosts << "www.api.ia-resume.com"
    config.hosts << "api.ia-resume.com"
    config.hosts << "www.api.ia-resume.com"
    config.hosts << "api.ia-resume.com:28080"
    config.hosts << "www.api.ia-resume.com:28080"
    config.action_cable.url = [/ws:\/\/*/, /wss:\/\/*/]
    config.action_cable.allowed_request_origins = [/http:\/\/*/, /https:\/\/*/]
    config.force_ssl = true
    config.action_cable.allowed_request_origins = [/http:\/\/*/, /https:\/\/*/]
    config.action_cable.allow_same_origin_as_host = true
    config.action_cable.url = "wss://api.ia-resume.com:28080/cable"
  end
end
