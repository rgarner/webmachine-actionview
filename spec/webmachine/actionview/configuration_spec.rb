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

    its(:view_paths) { should eql(paths) }
    its(:handlers) { should eql(handlers) }
    its(:default_layout) { should eql('layouts/some_default') }
  end
end