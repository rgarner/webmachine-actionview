class HomeResource < Webmachine::Resource
  include Webmachine::ActionView::Resource

  def to_html
    @home = HomeResource.home_instance
    render
  end

  def self.home_instance
    Struct.new(:id, :name).new.tap do |h|
      h.id = 1
      h.name = "some name"
    end
  end
end
