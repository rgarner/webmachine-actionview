module Webmachine
  module ActionView
    # Include on {::Webmachine::Resource}-derived classes to get access to ActionView-style templating.
    module Resource
      def self.included(base)
        base.class_eval do
          include ::ActionView::Helpers::CaptureHelper
          include ::ActionView::Context
        end
      end

      # Renders a template or partial with an optional layout from a `Webmachine::ActionView::Resource`
      #
      # @param [Hash] options Describe what you want to render. Leave blank to render the {#default_template_name}
      # @option options [String] :template Name of the template to render. Do not use with `:partial`
      # @option options [String] :partial Name of the template to render. Do not use with `:template`
      # @option options [String] :layout Name of the layout within which to render the template.
      # @option options [String] :locals `Hash` of locals to pass to a partial.
      #   Defaults to {Webmachine::ActionView::Resource::DEFAULT_LAYOUT}.
      #   Suppress with `layout: false` or `layout: nil`
      # @return [::ActionView::OutputBuffer] the output content
      def render(options = nil)
        options ||= default_template_name
        options = { :template => options } if options.is_a?(String)

        unless options[:partial]
          if options.has_key?(:layout) && !options[:layout]
            options.delete(:layout)
          else
            options.reverse_merge!(layout: Webmachine::ActionView.config.default_layout)
          end
          _prepare_context
        end

        view_renderer.render(self, options)
      end

      # The conventional template name for the resource. In a class called `HomeResource`, this would be 'home'
      #
      # @return [String] default template name for this resource
      def default_template_name
        @default_template_name ||= self.class.name.underscore.sub(/_resource$/, '')
      end

      # Lazily created path set. Configure first with {::Webmachine::ActionView.configure}
      # @return [::ActionView::PathSet] paths in which to find templates.
      def view_paths
        @view_paths ||= ::ActionView::PathSet.new(Webmachine::ActionView.config.view_paths)
      end

      # The `::ActionView::Context` in which views are looked up.
      # @return [::ActionView::Context]
      def lookup_context
        @lookup_context ||= ::ActionView::LookupContext.new(view_paths)
      end

      # The renderer responsible for rendering when #render is called
      # @return [::ActionView::Renderer] the renderer
      def view_renderer
        @view_renderer ||= ::ActionView::Renderer.new(lookup_context)
      end
    end
  end
end