# this is a generated file, to avoid over-writing it just delete this comment
begin
  require 'jar_dependencies'
rescue LoadError
  require 'org/voltdb/voltdbclient/8.3/voltdbclient-8.3.jar'
end

if defined? Jars
  require_jar 'org.voltdb', 'voltdbclient', '8.3'
end
