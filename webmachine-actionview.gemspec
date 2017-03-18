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

  gem.add_dependency "webmachine", '>= 1.0'
  gem.add_dependency "activesupport", '>= 3.2', '~> 5.0'
  gem.add_dependency "actionpack", '>= 3.2', '~> 5.0'

  gem.add_development_dependency "bundler"

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
