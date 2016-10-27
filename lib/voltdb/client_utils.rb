module Voltdb
  module ClientUtils
    java_import Java::OrgVoltdbTypes::TimestampType
    java_import Java::OrgVoltdbClient::Client

    def params_to_java_objects(*params)
      params.map do |param|
        case param
        when DateTime || Date
          TimestampType.new(param.strftime("%F %T.%L"))
        else
          param
        end
      end
    end

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
