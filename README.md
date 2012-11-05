# DelayedSunspot [![endorse](http://api.coderwall.com/anthonator/endorsecount.png)](http://coderwall.com/anthonator)

Adds support for indexing objects asynchronously using [Sunspot](https://github.com/sunspot/sunspot) and [Delayed Job](https://github.com/collectiveidea/delayed_job).

## Installation

Add this line to your application's Gemfile:

    gem 'delayed_sunspot'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install delayed_sunspot

## Usage

You will need to configure Sunspot to use delayed_sunspot's session proxy in order to push Sunspot commands through Delayed Job.

```ruby
Sunspot.session = Sunspot::SessionProxy::DelayedJobSessionProxy.new(Sunspot.session)
```

If you're using Rails put the above line of code in an initializer.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
