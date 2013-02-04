module Webmachine
  module ActionView
    def self.view_paths
      []
    end

    module Resource
      def default_template_name
        @default_template_name ||= self.class.name.underscore.sub(/_resource$/, '')
      end

      def view_paths
        @view_paths ||= ::ActionView::PathSet.new(Webmachine::ActionView.config.view_paths)
      end

      def lookup_context
        @lookup_context ||= ::ActionView::LookupContext.new(view_paths)
      end
    end
  end
end