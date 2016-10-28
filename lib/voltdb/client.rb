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

    def update_classes(jar_path, classes_to_delete, &block)
      if block_given?
        cb = ProcCallback.new(&block)
        java_client.update_classes(cb, jar_path, classes_to_delete)
      else
        java_client.update_classes(jar_path, classes_to_delete)
      end
    end

    def update_application_catalog(catalog_path, deployment_path, &block)
      if block_given?
        cb = ProcCallback.new(&block)
        java_client.update_application_catalog(cb, catalog_path, deployment_path)
      else
        java_client.update_application_catalog(catalog_path, deployment_path)
      end
    end

    def get_instance_id
      java_client.get_instance_id.to_ary
    end

    def get_throughput_and_outstanding_txn_limits
      java_client.get_throughput_and_outstanding_txn_limits.to_ary
    end

    def get_connected_host_list
      java_client.get_connected_host_list.to_ary
    end

    def get_new_bulk_loader(table_name, max_batch_size, upsert, &block)
      cb = BulkLoaderFailureCallback.new(&block)

      if upsert
        java_client.get_new_bulk_loader(table_name, max_batch_size, upsert, cb)
      else
        java_client.get_new_bulk_loader(table_name, max_batch_size, cb)
      end
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
      :create_connection, :drain, :close, :create_stats_context,
      :get_build_string, :write_summary_csv
  end
end
