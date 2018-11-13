module Voltdb
  class ProcCallback
    include Java::OrgVoltdbClient::ClientResponse
    include Java::OrgVoltdbClient::ProcedureCallback

    def initialize(&block)
      @block = block
    end

    def client_callback(client_response)
      client_response.extend(ClientResponseUtils)
      @block.call(client_response)
    end
  end

  class BulkLoaderFailureCallback
    java_import "org.voltdb.client.VoltBulkLoader.BulkLoaderFailureCallBack"
    include Java::OrgVoltdbClient::ClientResponse
    include Java::OrgVoltdbClientVoltBulkLoader::BulkLoaderFailureCallBack

    def initialize(&block)
      @block = block
    end

    def failure_callback(row_handle, field_list, client_response)
      client_response.extend(ClientResponseUtils)
      @block.call(row_handle, field_list.to_ary, client_response)
    end
  end

  class BulkLoaderSuccessCallback
    java_import "org.voltdb.client.VoltBulkLoader.BulkLoaderSuccessCallback"
    include Java::OrgVoltdbClient::ClientResponse
    include Java::OrgVoltdbClientVoltBulkLoader::BulkLoaderSuccessCallback

    def initialize(&block)
      @block = block
    end

    def success(row_handle, client_response)
      client_response.extend(ClientResponseUtils)
      @block.call(row_handle, client_response)
    end
  end

  class AllPartitionProcCallback
    java_import Java::OrgVoltdbClient::ClientResponseWithPartitionKey
    include Java::OrgVoltdbClient::AllPartitionProcedureCallback

    def initialize(&block)
      @block = block
    end

    def client_callback(client_response_with_partition_key)
      response = client_response_with_partition_key.map do |partition|
        partition.response.extend(ClientResponseUtils)
        partition
      end

      @block.call(response)
    end
  end
end
