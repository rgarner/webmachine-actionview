# Webmachine::Actionview

Integration of some Rails-style view conventions into Webmachine.

## Installation

Add this line to your application's Gemfile:

    gem 'webmachine-actionview'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install webmachine-actionview

## Usage

Include `Webmachine::ActionView::Resource` in resources you want to use ActionView. Somewhere in your app's
startup, you'll need to tell it where views live and (optionally) what handlers you're supporting, for example:

    Webmachine::ActionView.configure do |config|
      config.view_paths = [MY_VIEWS_PATH]
      config.handlers = [:erb, :haml, :builder]
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
