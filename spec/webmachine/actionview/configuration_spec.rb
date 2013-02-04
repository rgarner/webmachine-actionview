require 'spec_helper'

describe Webmachine::ActionView::Configuration do
  describe "Configuring" do
    let(:paths) { ['somewhere/over/the/rainbow'] }
    let(:exts) { ['erb', 'slim', 'haml'] }

    before do
      Webmachine::ActionView.configure do |c|
        c.view_paths = paths
        c.extensions = exts
      end
    end

    subject(:config) { Webmachine::ActionView.config }

    its(:view_paths) { should eql(paths) }
    its(:extensions) { should eql(exts) }
  end
end