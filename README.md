# Voltdb JRuby Client [![Build Status](https://travis-ci.org/full360/voltdb-client-jruby.svg?branch=master)](https://travis-ci.org/full360/voltdb-client-jruby)

A thin wrapper around the VoltDB Java client.

## Versions

We've decided that vendoring the `voltdbclient-x.x.jar` in the Gem as a
dependency is the right way to do it. We are using VoltDB 8.3 and for that
reason that's the one that's vendored. We are open on doing a different thing if
it's the right solution.

If required we could do multiple releases with different vendored clients. Just
open an issue.

## Installation

Add this line to your application's Gemfile:

    gem "voltdbjruby"

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install voltdbjruby

## Vendor

Installing and vendor jar dependencies from maven using `jar-dependencies` gem
and the `rake` task.

To update the vendored jar dependencies we use a new `rake` task called `vendor`
that will download jars from Maven and vendor them in the `lib/` directory.

    bundle exec rake vendor

## Usage

### Basic example

```ruby
require "voltdb"

# Create a config
config = Voltdb::ClientConfig.new()

# Create a client and pass the config
voltdb_client = Voltdb::Client.create_client(config)

# Create a connection
voltdb_client.create_connection("localhost")

# Synchronous example
response = voltdb_client.call_procedure("SampleProc", 123, "abc")

# Asynchronous example
queued = voltdb_client.call_procedure("SampleProc", 123, "abc") do |response|
  # interact with the async response...
end
```

### Utilities

Utilities are a custom addition from Full 360 to DRY things a little and add
some Ruby idioms.

#### ClientResponse utilities

```ruby
...

User = Struct.new(:id, :name)

# Synchronous example
response = voltdb_client.call_procedure("GetUsers")

response.map(0) do |row|
  User.new(row.get_long(0), row.get_string(1))
end

response = voltdb_client.call_procedure("GetUser", 1)

response.map_first_row(0) do |row|
  User.new(row.get_long(0), row.get_string(1))
end

# Asynchronous example
queued = voltdb_client.call_procedure("GetUsers") do |response|
  response.map(0) do |row|
    User.new(row.get_long(0), row.get_string(1))
  end
end
```

#### VoltTableRow utilities

```ruby
User = Struct.new(:id, :name, :active, :created_at)

response = voltdb_client.call_procedure("GetUser", 1)

response.map_first_row(0) do |row|
  User.new(
    row.get_long(0),
    row.get_string(1),
    row.get_long_as_boolean(2),
    row.get_timestamp_as_ruby_time(3)
  )
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can
also run `bin/console` for an interactive prompt that will allow you to
experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`.
If you have ownership rights run `bundle exec rake release`, which will create a
git tag for the version, push git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).
If you don't have create the git tags manually using the following format
`vX.X.X`, push them, Travis CI will make the rest happen.

The recommended way to release is using the Travis CI deploy integration.

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/full360/voltdb-client-jruby. This project is intended to be a
safe, welcoming space for collaboration, and contributors are expected to adhere
to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT
License](http://opensource.org/licenses/MIT).
