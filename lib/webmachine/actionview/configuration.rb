require 'active_support/configurable'

module Webmachine
  module ActionView

    # Configures settings for Webmachine::ActionView
    def self.configure(&block)
      yield @config ||= Configuration.new
    end

    def self.config
      @config
    end

    class Configuration #:nodoc:
      include ActiveSupport::Configurable

      config_accessor :view_paths, :extensions
    end
  end
end