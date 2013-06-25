require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'compass'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Console
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Hack to fix Compass in Rails 4
    # https://github.com/Compass/compass-rails/pull/59#issuecomment-17475702
    if defined?(Compass)
      config.assets.paths << Compass::Frameworks[:compass].stylesheets_directory
    end

    # Precompile additional assets (not sure if this is still needed?)
    config.assets.precompile += %w( .svg .eot .woff .ttf )
    
  end
end


