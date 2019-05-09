require 'spec_helper'

describe Webmachine::ActionView::Configuration do
  describe "Configuring" do
    let(:paths) { ['somewhere/over/the/rainbow'] }
    let(:handlers) { ['erb', 'slim', 'haml'] }

    before do
      Webmachine::ActionView.configure do |c|
        c.view_paths = paths
        c.handlers = handlers
        c.default_layout = 'layouts/some_default'
      end
    end

    subject(:config) { Webmachine::ActionView.config }

    example { expect(config.view_paths).to eql(paths) }
    example { expect(config.handlers).to eql(handlers) }
    example { expect(config.default_layout).to eql('layouts/some_default') }
  end
end