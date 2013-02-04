module Webmachine
  module ActionView
    def self.view_paths
      []
    end

    module Resource
      def self.included(base)
        base.class_eval do
          include ::ActionView::Helpers::CaptureHelper
          include ::ActionView::Context
        end
      end

      DEFAULT_LAYOUT = 'layouts/application'

      def render(options = nil)
        options ||= default_template_name
        options = { :template => options } if options.is_a?(String)

        unless options[:partial]
          if options.has_key?(:layout) && !options[:layout]
            options.delete(:layout)
          else
            options.reverse_merge!(layout: DEFAULT_LAYOUT)
          end
          _prepare_context
        end

        view_renderer.render(self, options)
      end

      def default_template_name
        @default_template_name ||= self.class.name.underscore.sub(/_resource$/, '')
      end

      def view_paths
        @view_paths ||= ::ActionView::PathSet.new(Webmachine::ActionView.config.view_paths)
      end

      def lookup_context
        @lookup_context ||= ::ActionView::LookupContext.new(view_paths)
      end

      def view_renderer
        @view_renderer ||= ::ActionView::Renderer.new(lookup_context)
      end
    end
  end
end