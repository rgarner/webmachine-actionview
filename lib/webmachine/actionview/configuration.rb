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

      DEFAULT_LAYOUT = 'layouts/application'

      config_accessor :view_paths, :handlers, :default_layout
    end

    configure do |c|
      c.default_layout = Configuration::DEFAULT_LAYOUT
    end
  end
end