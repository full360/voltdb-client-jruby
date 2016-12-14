module Voltdb
  module ClientResponseUtils
    java_import Java::OrgVoltdbClient::Client
    java_import Java::OrgVoltdbClient::ClientResponse
    java_import Java::OrgVoltdb::VoltTableRow

    # This method is used for mapping VoltTableRows to an object. It receives
    # the index of the VoltTable that we want to map and a block that will be
    # executed in that context
    #
    # @param client_response [ClientResponseImpl] a voltdb ClientResponse
    #   interface implementation
    # @param index [Fixnum] VoltTable index
    # @param validate_status [Boolean] validate status of the client response
    # @yield [VoltTableRow]
    # @return [Array<Object, Object>]
    def self.map_client_response_result(client_response, index, validate_status = true, &block)
      validate_client_response_status(client_response) if (validate_status)
      VoltTableUtils.map_volt_table(client_response.get_results[index], &block)
    end

    # This method is used for mapping the first row from a VoltTableRow to an
    # object.  It receives the index of the VoltTable that we want to map and a
    # block that will be executed in that context
    #
    # @param client_response [ClientResponseImpl] a voltdb ClientResponse
    #   interface implementation
    # @param index [Fixnum] VoltTable index
    # @param validate_status [Boolean] validate status of the client response
    # @yield [VoltTableRow]
    # @return [Array<Object>]
    def self.map_first_row_from_client_response_result(client_response, index, validate_status = true, &block)
      validate_client_response_status(client_response) if (validate_status)
      VoltTableUtils.map_first_row_from_volt_table(client_response.get_results[index], &block)
    end

    # Checks that the status of the client response is SUCCESS. If not, it
    # throws an exception
    #
    # @param client_response [ClientResponseImpl] a voltdb ClientResponse
    #   interface implementation
    # @return the same client response passed in when its status is equal to
    #   <code>ClientResponse.SUCCESS</code>
    # @raise [ClientResponseStatusError] if the status is not SUCCESS
    def self.validate_client_response_status(client_response)
      unless ClientResponse.SUCCESS == client_response.get_status
        raise ClientResponseStatusError.new(client_response)
      end

      client_response
    end
    # This method is used when we extend the Voltdb ClientResponse interface
    # and it's used for mapping VoltTableRows to an object. It receives the
    # index of the VoltTable that we want to map and a block that will be
    # executed in that context
    #
    # @param index [Fixnum] VoltTable index
    # @yield [VoltTableRow]
    # @return [Array<Object, Object>]
    def map(index, validate_status = true, &block)
      ClientResponseUtils.map_client_response_result(self, index, validate_status, &block)
    end

    # This method is used when we extend the Voltdb ClientResponse interface
    # and it's used for mapping the first row from a VoltTableRow to an object.
    # It receives the index of the VoltTable that we want to map and a block
    # that will be executed in that context
    #
    # @param index [Fixnum] VoltTable index
    # @yield [VoltTableRow]
    # @return [Array<Object>]
    def map_first_row(index, validate_status = true, &block)
      ClientResponseUtils.map_first_row_from_client_response_result(self, index, validate_status, &block)
    end

    # This method is used when we extend the Voltdb ClientResponse interface
    # and it's used for valitation on the client response
    #
    # @return [client_response]
    def validate_status
      ClientResponseUtils.validate_client_response_status(self)
    end
  end
end
