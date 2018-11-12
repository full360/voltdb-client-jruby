module Voltdb
  class Client
    include ClientUtils
    extend Forwardable

    java_import Java::OrgVoltdbClient::Client
    java_import Java::OrgVoltdbClient::ClientFactory

    # Persist ClientResponseImpl to avoid the warning when we extend the object
    Java::OrgVoltdb::ClientResponseImpl.__persistent__ = true

    attr_reader :java_client

    # Factory of Voltdb::Client
    #
    # @param config Voltdb::ClientConfig
    # @return Voltdb::Client
    def self.create_client(config)
      client = ClientFactory.create_client(config)

      self.new(client)
    end

    def initialize(java_client)
      @java_client = java_client
    end

    # Invokes a voltdb stored procedure based on its procedure name, a list of
    # params and a block only if an asynchronous call is required
    #
    # @param proc_name [String] the stored procedure name
    # @param *params [Array<Object>] a list of params
    # @return [Java::OrgVoltdbClient::ClientResponse, True, False] Voltdb
    #   client response if the procedure was called synchronously, else will
    #   return true if the procedure was properly queued or false if it was not
    # @raise [ProcCallException, NoConnectionsException, IOException]
    #   ProcCallException will be returned if called synchronously
    def call_procedure(proc_name, *params, &block)
      if block_given?
        cb = ProcCallback.new(&block)
        java_client.call_procedure(cb, proc_name, *params_to_java_objects(*params))
      else
        response = java_client.call_procedure(proc_name, *params_to_java_objects(*params))
        response.extend(ClientResponseUtils)
        response
      end
    end

    # Invokes a voltdb stored procedure with an specific timeout a procedure
    # name, a list of params and a block only if an asynchronous call is
    # required
    #
    # @param query_timeout [Fixnum] the stored procedure timeout
    # @param proc_name [String] the stored procedure name
    # @param *params [Array<Object>] a list of params
    # @return [Java::OrgVoltdbClient::ClientResponse, True, False] Voltdb
    #   client response if the procedure was called synchronously, else will
    #   return true if the procedure was properly queued or false if it was not
    # @raise [ProcCallException, NoConnectionsException, IOException]
    #   ProcCallException will be returned if called synchronously
    def call_procedure_with_timeout(query_timeout, proc_name, *params, &block)
      if block_given?
        cb = ProcCallback.new(&block)
        java_client.call_procedure_with_timeout(cb, query_timeout, proc_name, *params_to_java_objects(*params))
      else
        response = java_client.call_procedure_with_timeout(query_timeout, proc_name, *params_to_java_objects(*params))
        response.extend(ClientResponseUtils)
        response
      end
    end

    # This method is a convenience method that is equivalent to reading a
    # jarfile containing to be added/updated into a byte array in Java code,
    # then calling call_procedure with "@UpdateClasses" as the procedure name,
    # followed by the bytes of the jarfile and a string containing a
    # comma-separates list of classes to delete from the catalog.If a block is
    # passed to the method an asyncronous call will be made
    #
    # @param jar_path [String] path to the jar file with new/update clases
    # @param classes_to_delete [String,String] comma-separated list of classes
    #   to delete
    # @return [Java::OrgVoltdbClient::ClientResponse, True, False] Voltdb
    #   client response if the procedure was called synchronously, else will
    #   return true if the procedure was properly queued or false if it was not
    # @raise [ProcCallException, NoConnectionsException, IOException]
    #   ProcCallException will be returned if called synchronously
    def update_classes(jar_path, classes_to_delete, &block)
      if block_given?
        cb = ProcCallback.new(&block)
        java_client.update_classes(cb, jar_path, classes_to_delete)
      else
        response = java_client.update_classes(jar_path, classes_to_delete)
        response.extend(ClientResponseUtils)
        response
      end
    end

    # Get an identifier for the cluster that this client is currently connected
    # to. This will be null if the client has not been connected. Currently
    # these values have logical meaning, but they should just be interpreted as
    # a unique per-cluster value
    #
    # @return [Array<Fixnum>] An array of Fixnum containing the millisecond
    #   timestamp when the cluster was started and the leader IP address
    def get_instance_id
      java_client.get_instance_id.to_ary
    end

    # Get the instantaneous values of the rate limiting values for this client
    #
    # @return [Array<Fixnum>] Array of Fixnum representing max throughput/sec
    #   and max outstanding txns
    def get_throughput_and_outstanding_txn_limits
      java_client.get_throughput_and_outstanding_txn_limits.to_ary
    end

    # Get the list of VoltDB server hosts that this client has open TCP
    # connections to
    #
    # @return [Array<InetSocketAddress>] An list of InetSocketAddress
    #   representing the connected hosts
    def get_connected_host_list
      java_client.get_connected_host_list.to_ary
    end

    # Creates a new instance of a VoltBulkLoader that is bound to this Client.
    # Multiple instances of a VoltBulkLoader created by a single Client will
    # share some resources, particularly if they are inserting into the same
    # table
    #
    # @param table_name [String] that bulk inserts are to be applied to
    # @param max_batch_size [Fixnum] to collect for the table before pushing a
    #   bulk insert
    # @param [Boolean] upsert true if want upsert instead of insert
    # @return [VoltBulkLoader]
    # @raise [Exception] if tableName can't be found in the catalog
    def get_new_bulk_loader(table_name, max_batch_size, upsert, &block)
      cb = BulkLoaderFailureCallback.new(&block)

      if upsert
        java_client.get_new_bulk_loader(table_name, max_batch_size, upsert, cb)
      else
        java_client.get_new_bulk_loader(table_name, max_batch_size, cb)
      end
    end

    # The method uses system procedure @GetPartitionKeys to get a set of
    # partition values and then execute the stored procedure one partition at a
    # time, and return an aggregated response. If a block is passed to the
    # method an asyncronous call will be made
    #
    # @param proc_name [String] proc_name the stored procedure name
    # @param *param [Array<Object>] a list of params
    # @return [ClientResponseWithPartitionKey, True, False] instances of
    #   procedure call results
    # @raise [ProcCallException, NoConnectionsException, IOException]
    def call_all_partition_procedure(proc_name, *params, &block)
      if block_given?
        cb = AllPartitionProcCallback.new(&block)
        java_client.call_all_partition_procedure(cb, proc_name, *params_to_java_objects(*params))
      else
        java_client.call_all_partition_procedure(proc_name, *params_to_java_objects(*params)).map do |partition|
          partition.response.extend(ClientResponseUtils)
          partition
        end
      end
    end

    def_delegators :java_client,
      :create_connection, :drain, :close, :create_stats_context,
      :get_build_string, :write_summary_csv
  end
end
