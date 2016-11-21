module Voltdb
  class ClientResponseStatusError < StandardError
    attr_reader :client_response

    def initialize(client_response, message = "Client response not successful")
      @client_response = client_response
      super(message)
    end
  end
end
