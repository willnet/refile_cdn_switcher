# RefileCdnSwitcher

If you use refile and have to deal with sensitive file, you can use [Authentication](https://github.com/refile/refile#authentication). But if you use CDN(you should use CDN), users can bypass it.

RefileCdnSwitcher disable CDN by default and enable it selectively.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'refile_cdn_switcher'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install refile_cdn_switcher

## prerequisite

RefileCdnSwitcher depends on `root_url`.


config/routes.rb

```ruby
root 'yourcontroller#youraction'
```

config/environments/*.rb

```ruby
Rails.application.routes.default_url_options = { host: 'yourhost', port: 'yourport' }
```

## Usage

If you want to use cdn, you can pass `cdn: true` option to attachment method. (and ofcource set Refile.cdn_host)

```ruby
class User < ApplicationRecord
  attachment :file, cdn: true
end
```

If you doesn't pass cdn option, it means that cdn is disabled with the file.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/willnet/refile_cdn_switcher. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RefileCdnSwitcher project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/willnet/refile_cdn_switcher/blob/master/CODE_OF_CONDUCT.md).
