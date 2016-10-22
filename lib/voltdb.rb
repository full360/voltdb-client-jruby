require "java/voltdbclient-6.6.jar"

module Voltdb
  java_import Java::OrgVoltdbClient::Client
  java_import Java::OrgVoltdbClient::ClientConfig
  java_import Java::OrgVoltdbClient::ClientFactory
  java_import Java::OrgVoltdbClient::ClientResponse
  java_import Java::OrgVoltdbClient::ProcedureCallback

  DEFAULT_PORT = 21212

  def config(username, password)
    ClientConfig.new(username, password)
  end

  def client(config)
    @client = ClientFactory.create_client(config)
  end

  def connect_or_fail(*addresses)
    connect(*addresses)
  rescue Java::JavaNet::ConnectException => e
    # Raise custom connection refused exception
    puts "catched: #{e.message}"
  end

  def connect(*addresses)
    addresses.each do |address|
      address, port = host_and_port_from_address(address)
      create_connection(address, port)
    end
    nil
  end

  def create_connection(address, port)
    @client.create_connection(address, port)
  end

  def host_and_port_from_address(address, default_port = DEFAULT_PORT)
    s = address.split(":")

    case s.size
    when 1
      ["#{s[0]}", default_port]
    when 2
      ["#{s[0]}", s[1].to_i]
    else
      ["", 0]
    end
  end

  def call_procedure(procedure_name, *params)
    @client.call_procedure(procedure_name, *params)
  end

  autoload :VERSION,       "voltdb/version"
end
