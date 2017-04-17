$:.unshift(File.join(File.dirname(__FILE__), "..", "..", "lib"))

require "voltdb"
java_import Java::OrgVoltdbClient::ClientResponse

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

response = client.call_procedure("Select", "Spanish")

if response.get_status != ClientResponse.SUCCESS
  puts response.get_status_string
  exit 1
end

results = response.get_results

if results.length == 0 || results[0].get_row_count != 1
  puts "I can't say Hello in that language.\n"
  exit 1
end

result_table = results[0]
row = result_table.fetch_row(0)
puts "#{row.get_string("hello")}, #{row.get_string("world")}!\n"
