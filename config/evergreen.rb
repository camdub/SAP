#require 'capybara-webkit'

Evergreen.configure do |config|
  config.driver = :webkit
  config.public_dir = 'public/assets'
  config.template_dir = 'templates'
  config.spec_dir = 'spec'
end

# For Rails 3.1 asset packaging / sprockets support
# 1. Create a /config/evergreen.rb file and put these contents in it
# 2. Adjust the paths below (the provided ones are generic)
require ::File.expand_path('../application',  __FILE__)

module Evergreen

  class << self
    def application_with_additions(suite)
      puts 'sprokects1-----------------2345'
      app = application_without_additions(suite)

      app.map "/assets" do
        assets = Rails.application.config.assets
        if assets.enabled
          paths = %W{app/assets/javascripts lib/assets/javascripts vendor/assets/javascripts}.map{ |p| File.join(suite.root, p) }

          require 'sprockets'

          sprockets = Sprockets::Environment.new(suite.root) do |env|
            paths.each { |path| env.append_path(path) }
            env.js_compressor = nil
          end

          run sprockets
        end
      end
      app
    end

    alias_method :application_without_additions, :application
    alias_method :application, :application_with_additions
  end

end