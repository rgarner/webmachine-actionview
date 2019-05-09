require "spec_helper"

class BaseResource < Webmachine::Resource
  include Webmachine::ActionView::Resource
end

class UnconventionalName < BaseResource
end

describe "A resource including Webmachine::ActionView::Resource" do
  let(:request)  { nil }
  let(:response) { nil }

  let(:resource)                { HomeResource.new(request, response) }
  let(:unconventional_resource) { UnconventionalName.new(request, response) }

  before do
    Webmachine::ActionView.configure do |c|
      c.view_paths = ['spec/dummy/views']
      c.default_layout = 'layouts/application'
    end
  end

  describe "Default places to look for templates" do
    describe "the path set" do
      subject(:view_paths) { resource.view_paths }

      it { should be_an(ActionView::PathSet) }
      it "has the path we previously configured" do
        expect(view_paths.paths.map(&:to_s)).to include(File.expand_path('spec/dummy/views'))
      end
    end

    context "A conventionally-named resource" do
      it "looks for a template without resource in the class name" do
        expect(resource.default_template_name).to eql('home')
      end
    end
    context "An unconventionally-named resource" do
      it "looks for a template as an underscored version of its class name" do
        expect(unconventional_resource.default_template_name).to eql('unconventional_name')
      end
    end
  end

  describe "Finding templates through the lookup context" do
    subject(:lookup_context) { resource.lookup_context }

    it { should be_an(ActionView::LookupContext) }

    it "finds templates implicitly" do
      expect(lookup_context.find('home')).to be_a(ActionView::Template)
    end
    it "finds templates implicitly when html is mentioned" do
      expect(lookup_context.find('home.html')).to be_a(ActionView::Template)
    end
    it "fails to find templates for unmentioned extensions" do
      expect { resource.lookup_context.find('foo') }.to raise_error(ActionView::MissingTemplate)
    end
  end

  describe "Rendering from a template with a context" do
    subject(:rendered) { resource.to_html }

    it { is_expected.to include('id: 1') }
    it { is_expected.to include('name: some name') }

    it { is_expected.to include('content from the application layout')}
    it { is_expected.to include('content from shared/some_partial')}
    it { is_expected.to include('local content')}
  end

  describe "Explicit template rendering" do
    subject(:rendered) { resource.to_html }

    context "With an explicit layout" do
      let(:resource) do
        HomeResource.new(request, response).tap do |h|
          def h.to_html
            @home = HomeResource.home_instance
            render template: 'home', layout: 'layouts/explicit'
          end
        end
      end

      it "should include explicit content" do
        expect(rendered).to include('FUSKING CLOFF PRUNKER')
      end
    end
    context "Suppressing default layout" do
      let(:resource) do
        HomeResource.new(request, response).tap do |h|
          def h.to_html
            @home = HomeResource.home_instance
            render template: 'home', layout: false
          end
        end
      end

      it "should not include explicit content" do
        expect(rendered).not_to include('FUSKING CLOFF PRUNKER')
      end
    end
  end
end