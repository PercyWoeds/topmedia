require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'csv'

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module Mnygo
  class Application < Rails::Application
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
    
    config.assets.precompile += ["*.js", "*.scss", "*.jpg", "*.png"]
    
  end
end
