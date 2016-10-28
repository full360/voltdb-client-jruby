module Voltdb
  class ClientConfig < Java::OrgVoltdbClient::ClientConfig; end

  class Client
    include ClientUtils
    extend Forwardable

    java_import Java::OrgVoltdbClient::Client
    java_import Java::OrgVoltdbClient::ClientFactory

    attr_reader :java_client

    def self.create_client(config)
      client = ClientFactory.create_client(config)

      self.new(client)
    end

    def initialize(java_client)
      @java_client = java_client
    end

    def call_procedure(proc_name, *params, &block)
      if block_given?
        cb = ProcCallback.new(&block)
        java_client.call_procedure(cb, proc_name, *params_to_java_objects(*params))
      else
        java_client.call_procedure(proc_name, *params_to_java_objects(*params))
      end
    end

    def call_procedure_with_timeout(query_timeout, proc_name, *params, &block)
      if block_given?
        cb = ProcCallback.new(&block)
        java_client.call_procedure_with_timeout(cb, query_timeout, proc_name, *params_to_java_objects(*params))
      else
        java_client.call_procedure_with_timeout(query_timeout, proc_name, *params_to_java_objects(*params))
      end
    end

    def get_instance_id
      java_client.get_instance_id.to_ary
    end

    def call_all_partition_procedure(proc_name, *params, &block)
      if block_given?
        cb = AllPartitionProcCallback.new(&block)
        java_client.call_all_partition_procedure(cb, proc_name, *params_to_java_objects(*params))
      else
        java_client.call_all_partition_procedure(proc_name, *params_to_java_objects(*params)).to_ary
      end
    end

    def_delegators :java_client,
      :create_connection, :update_application_catalog, :update_classes, :drain,
      :close, :create_stats_context, :get_build_string, :get_new_bulk_loader,
      :get_throughput_and_outstanding_txn_limits, :get_connected_host_list,
      :write_summary_csv
  end
end
