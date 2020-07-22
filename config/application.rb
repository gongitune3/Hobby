require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Hobby
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end

Refile.secret_key = '3870821f45afd45a21436c32508439c891174f90ad1051156858ecf3af46aa9c099ffa05624b9ab0b60166bd27f55e3aa5b18c9ccf2dc66083a649a5010da5d7'
