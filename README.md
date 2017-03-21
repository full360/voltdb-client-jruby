# Voltdb JRuby Client

A thin wrapper around the VoltDB Java client.

## Installation

Add this line to your application's Gemfile:

    gem "voltdbjruby"

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install voltdbjruby

Use `jbundler`, `lock_jar` or a similar to download and load the `voltdbclient`
jar in the CLASSPATH. For example using `jbundler`:

    echo "jar \"org.voltdb:voltdbclient\", \"6.8\"" > Jarfile

Install out java dependencies

    jruby -S jbundle install

Then require `jbundler` in your code to load it in the CLASSPATH

    require "jbundler"

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
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/full360/voltdb-client-jruby. This project is intended to be a
safe, welcoming space for collaboration, and contributors are expected to adhere
to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT
License](http://opensource.org/licenses/MIT).
