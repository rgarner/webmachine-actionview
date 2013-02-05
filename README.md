# Webmachine::Actionview

Integration of some Rails-style view conventions into Webmachine.  Uses your resource as a view context.

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

```ruby
Webmachine::ActionView.configure do |config|
  config.view_paths = [MY_VIEWS_PATH]
  config.handlers = [:erb, :haml, :builder]
end
```

In your resource, you'll need to render the view at some point.  Rendering is broadly similar to that in Rails.
The simplest thing you can do is this:

```ruby
class HomeResource < Webmachine::Resource
  include Webmachine::ActionView::Resource
  def to_html
    render
  end
end
```

This will look for a template called "home" in your `Webmachine::ActionView.configuration.view_paths`.  By default, this
will look for an application layout of `layouts/application`.

You can be more specific:

```ruby
render template: 'other_template', layout: 'mini'
```

You can suppress a layout:

```ruby
render layout: nil
# or
render layout: false
```

Your resource itself is used as the view context. This means that you can use instance variables as you would in Rails.
For example:

```ruby
class Customer << Webmachine::Resource
  include Webmachine::ActionView::Resource

  def resource_exists?
    @customer = Customer.find(some_id)
  end

  def to_html
    render
  end
end
```

And in an associated `customer.html.erb` template, `@customer` will be available:

```erb
<p class="name"><%= @customer.name %></p>
```

You can also render partials from your views:

```ruby
render partial: 'shared/my_partial'
```

Partials are subject to the same conventions as Rails, i.e. their filenames begin with an underscore, but no underscore
is required when making a call to `render partial: 'some_partial'`.

## Thanks

This gem came about a lot quicker due to someone else already having fiddled with the internals of ActionView.
The link I originally found is https://github.com/newhavenrb/conferences/wiki/Using-Rails-without-Rails, so I think
that means thanks to @drogus - pretty sure those are his slides linked to from that page.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
