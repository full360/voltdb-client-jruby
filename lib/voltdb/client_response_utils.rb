module Voltdb
  module ClientResponseUtils
    java_import Java::OrgVoltdbClient::Client
    java_import Java::OrgVoltdb::VoltTableRow

    # This method is used for mapping VoltTableRows to an object. It receives
    # the index of the VoltTable that we want to map and a block that will be
    # executed in that context
    #
    # @param client_response [ClientResponseImpl] a voltdb ClientResponse
    #   interface implementation
    # @param index [Fixnum] VoltTable index
    # @yield [VoltTableRow]
    # @return [Array<Object, Object>]
    def self.map_client_response_result(client_response, index, &block)
      VoltTableUtils.map_volt_table(client_response.get_results[index], &block)
    end

    # This method is used for mapping the first row from a VoltTableRow to an
    # object.  It receives the index of the VoltTable that we want to map and a
    # block that will be executed in that context
    #
    # @param client_response [ClientResponseImpl] a voltdb ClientResponse
    #   interface implementation
    # @param index [Fixnum] VoltTable index
    # @yield [VoltTableRow]
    # @return [Array<Object>]
    def self.map_first_row_from_client_response_result(client_response, index, &block)
      VoltTableUtils.map_volt_table(client_response.get_results[index], &block)
    end

    # This method is used when we extend the Voltdb ClientResponse interface
    # and it's used for mapping VoltTableRows to an object. It receives the
    # index of the VoltTable that we want to map and a block that will be
    # executed in that context
    #
    # @param index [Fixnum] VoltTable index
    # @yield [VoltTableRow]
    # @return [Array<Object, Object>]
    def map(index, &block)
      ClientResponseUtils.map_client_response_result(self, index, &block)
    end

    # This method is used when we extend the Voltdb ClientResponse interface
    # and it's used for mapping the first row from a VoltTableRow to an object.
    # It receives the index of the VoltTable that we want to map and a block
    # that will be executed in that context
    #
    # @param index [Fixnum] VoltTable index
    # @yield [VoltTableRow]
    # @return [Array<Object>]
    def map_first_row(index, &block)
      ClientResponseUtils.map_first_row_from_client_response_result(self, index, &block)
    end
  end
end
