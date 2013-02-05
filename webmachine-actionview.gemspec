# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'webmachine/actionview/version'

Gem::Specification.new do |gem|
  gem.name          = "webmachine-actionview"
  gem.version       = Webmachine::ActionView::VERSION
  gem.authors       = ["Russell Garner"]
  gem.email         = ["rgarner@zephyros-systems.co.uk"]
  gem.description   = %q{Brings ActionView to webmachine-ruby}
  gem.summary       = %q{Want the Rails conventions that you're used to for HTML views in webmachine-ruby? This is your gem.}
  gem.homepage      = "http://github.com/rgarner/webmachine-actionview"

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "webmachine-test"

  gem.add_runtime_dependency "webmachine"
  gem.add_runtime_dependency "activesupport"
  gem.add_runtime_dependency "actionpack"

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
