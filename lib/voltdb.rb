require "java/voltdbclient-6.6.jar"
require "forwardable"
require "date"

module Voltdb
  autoload :ClientUtils,  "voltdb/client_utils"
  autoload :ClientConfig, "voltdb/client"
  autoload :Client,       "voltdb/client"
  autoload :VERSION,      "voltdb/version"
end
