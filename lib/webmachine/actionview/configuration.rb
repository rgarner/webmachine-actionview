require 'active_support/configurable'

module Webmachine
  module ActionView

    # Configures settings for {Webmachine::ActionView}
    # @return [Webmachine::ActionView::Configuration]
    # @example
    #   Webmachine::ActionView.configure do |config|
    #     config.view_paths = [MY_VIEWS_PATH]
    #     config.handlers = [:erb, :haml, :builder]
    #   end
    def self.configure(&block)
      yield @config ||= Configuration.new
    end

    # @return [Webmachine::ActionView::Configuration]
    def self.config
      @config
    end

    class Configuration #:nodoc:
      include ActiveSupport::Configurable

      config_accessor :view_paths, :handlers
    end
  end
end