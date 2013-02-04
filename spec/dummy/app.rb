require 'dummy/resources/home_resource'

module Dummy
  Application = Webmachine::Application.new do |app|
  end

  Application.routes do
    add [], HomeResource
  end
end

