module Voltdb
  class ClientConfig < Java::OrgVoltdbClient::ClientConfig; end

  class Client
    include ClientUtils
    extend Forwardable

    java_import Java::OrgVoltdbClient::Client
    java_import Java::OrgVoltdbClient::ClientFactory
    java_import Java::OrgVoltdbClient::ClientResponse
    java_import Java::OrgVoltdbClient::ProcedureCallback

    attr_reader :java_client

    def self.create_client(config)
      client = ClientFactory.create_client(config)

      self.new(client)
    end

    def initialize(java_client)
      @java_client = java_client
    end

    def java_client
      @java_client
    end

    def call_procedure(proc_name, *params)
      @java_client.call_procedure(proc_name, *params_to_java_objects(*params))
    end

    def call_procedure_with_timeout(query_timeout, proc_name, *params)
      @java_client.call_procedure(query_timeout, proc_name, *params_to_java_objects(*params))
    end

    def get_instance_id
      @java_client.get_instance_id.to_ary
    end

    def_delegators :@java_client,
      :create_connection, :update_application_catalog, :update_classes, :drain,
      :close, :create_stats_context, :get_build_string,
      :get_throughput_and_outstanding_txn_limits, :get_connected_host_list,
      :write_summary_csv, :get_new_bulk_loader, :call_all_partition_procedure
  end
end
