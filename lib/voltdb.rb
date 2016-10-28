require "java/voltdbclient-6.6.jar"
require "forwardable"
require "date"

module Voltdb
  autoload :ClientConfig,              "voltdb/client"
  autoload :ClientUtils,               "voltdb/client_utils"
  autoload :Client,                    "voltdb/client"
  autoload :ProcCallback,              "voltdb/callbacks"
  autoload :BulkLoaderFailureCallback, "voltdb/callbacks"
  autoload :AllPartitionProcCallback,  "voltdb/callbacks"
  autoload :VERSION,                   "voltdb/version"
end
