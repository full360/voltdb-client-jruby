require "java/voltdbclient-6.6.jar"
require "forwardable"

module Voltdb
  autoload :ClientConfig, "voltdb/client"
  autoload :Client,       "voltdb/client"
  autoload :VERSION,      "voltdb/version"
end
