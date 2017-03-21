require "forwardable"
require "date"

module Voltdb
  autoload :ClientResponseStatusError, "voltdb/exceptions"
  autoload :ClientConfig,              "voltdb/client"
  autoload :ClientUtils,               "voltdb/client_utils"
  autoload :Client,                    "voltdb/client"
  autoload :ProcCallback,              "voltdb/callbacks"
  autoload :BulkLoaderFailureCallback, "voltdb/callbacks"
  autoload :AllPartitionProcCallback,  "voltdb/callbacks"
  autoload :ClientResponseUtils,       "voltdb/client_response_utils"
  autoload :VoltTableUtils,            "voltdb/volt_table_utils"
  autoload :VoltTableRowUtils,         "voltdb/volt_table_row_utils"
  autoload :VERSION,                   "voltdb/version"
end
