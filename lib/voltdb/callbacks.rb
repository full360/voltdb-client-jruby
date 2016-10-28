module Voltdb
  class ProcCallback
    include Java::OrgVoltdbClient::ClientResponse
    include Java::OrgVoltdbClient::ProcedureCallback

    def initialize(&block)
      @block = block
    end

    def client_callback(client_response)
      @block.call(client_response)
    end
  end

  class AllPartitionProcCallback
    java_import Java::OrgVoltdbClient::ClientResponseWithPartitionKey
    include Java::OrgVoltdbClient::AllPartitionProcedureCallback

    def initialize(&block)
      @block = block
    end

    def client_callback(client_response_with_partition_key)
      @block.call(client_response_with_partition_key.to_ary)
    end
  end
end
