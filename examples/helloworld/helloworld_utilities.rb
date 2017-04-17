# load the lib dir
require "voltdb"

config = Voltdb::ClientConfig.new()
config.set_reconnect_on_connection_loss(true)
client = Voltdb::Client.create_client(config)
client.create_connection("localhost")

client.call_procedure("@AdHoc", "DELETE FROM helloworld")
client.call_procedure("Insert", "English", "Hello", "World")
client.call_procedure("Insert", "French", "Bonjour", "Monde")
client.call_procedure("Insert", "Spanish", "Hola", "Mundo")
client.call_procedure("Insert", "Danish", "Hej", "Verden")
client.call_procedure("Insert", "Italian", "Ciao", "Mondo")

HelloWorld = Struct.new(:hello, :world)

response = client.call_procedure("Select", "Spanish").map_first_row(0) do |row|
  HelloWorld.new(row.get_string("hello"), row.get_string("world"))
end

unless response
  puts "I can't say Hello in that language.\n"
  exit 1
end

puts "#{response.hello}, #{response.world}!\n"
