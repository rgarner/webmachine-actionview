require "spec_helper"

class SomethingWithActionViewResource < Webmachine::Resource
  include Webmachine::ActionView::Resource
end

class UnconventionalName < Webmachine::Resource
  include Webmachine::ActionView::Resource
end

describe SomethingWithActionViewResource do
  let(:request)  { nil }
  let(:response) { nil }

  let(:resource)                { SomethingWithActionViewResource.new(request, response) }
  let(:unconventional_resource) { UnconventionalName.new(request, response) }

  before :all do
    Webmachine::ActionView.configure do |c|
      c.view_paths = ['spec/dummy/views']
    end
  end

  describe "Default places to look for templates" do
    describe "the path set" do
      subject(:view_paths) { resource.view_paths }

      it { should be_an(ActionView::PathSet) }
      it "has the path we previously configured" do
        view_paths.paths.map(&:to_s).should include(File.expand_path('spec/dummy/views'))
      end
    end

    context "A conventionally-named resource" do
      it "looks for a template without resource in the class name" do
        resource.default_template_name.should == 'something_with_action_view'
      end
    end
    context "An unconventionally-named resource" do
      it "looks for a template as an underscored version of its class name" do
        unconventional_resource.default_template_name.should == 'unconventional_name'
      end
    end
  end

  describe "Finding templates through the lookup context" do
    subject(:lookup_context) { resource.lookup_context }

    it { should be_an(ActionView::LookupContext) }

    it "finds templates implicitly" do
      resource.lookup_context.find('home').should be_a(ActionView::Template)
    end
    it "finds templates implicitly when html is mentioned" do
      resource.lookup_context.find('home.html').should be_a(ActionView::Template)
    end
    it "fails to find templates for unmentioned extensions" do
      lambda { resource.lookup_context.find('foo') }.should raise_error(ActionView::MissingTemplate)
    end
  end
end