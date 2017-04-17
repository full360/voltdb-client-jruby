# load the lib dir
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

queued = client.call_procedure("Select", "Spanish") do |response|
  if response.get_status != ClientResponse.SUCCESS
    puts response.get_status_string
    return
  end

  results = response.get_results

  if results.length == 0 || results[0].get_row_count != 1
    puts "I can't say Hello in that language.\n"
    return
  end

  result_table = results[0]
  row = result_table.fetch_row(0)
  puts "#{row.get_string("hello")}, #{row.get_string("world")}!\n"
end

puts "Operation queued: #{queued}"
5.times { puts "Doing something else..." }
sleep 2
puts "Done"
