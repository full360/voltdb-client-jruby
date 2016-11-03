module Voltdb
  module ClientUtils
    java_import Java::OrgVoltdbTypes::TimestampType
    java_import Java::OrgVoltdbClient::Client

    # Transform Ruby objects to Java objects that VoltDB understands
    #
    # @param *params [Array<Object>] list of params
    # @return [Array<JavaObjects>]
    def params_to_java_objects(*params)
      params.map do |param|
        case param
        when DateTime, Date, Time
          TimestampType.new(param.strftime("%F %T.%L"))
        else
          param
        end
      end
    end

    # Transform a host:port or a host into an array of host and port
    #
    # @param address [String] voltdb server address
    # @param default_port [Fixnum] override the default voltdb server port
    # @return [Array<String, Fixnum>] represents host address and port
    def host_and_port_from_address(address, default_port = Client.VOLTDB_SERVER_PORT)
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
  end
end
