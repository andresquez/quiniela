require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Quiniela
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

    def store_location 
      session['saved_location'] = request.request_uri 
    end

    def redirect_to_back_or_default(default)
      if session['saved_location']
        redirect_to session['saved_location']
        session['saved_location'] = nil
      else
        redirect_to default
      end
    end

  end
end
