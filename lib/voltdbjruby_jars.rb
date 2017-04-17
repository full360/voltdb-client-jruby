# this is a generated file, to avoid over-writing it just delete this comment
begin
  require 'jar_dependencies'
rescue LoadError
  require 'org/voltdb/voltdbclient/6.8/voltdbclient-6.8.jar'
end

if defined? Jars
  require_jar( 'org.voltdb', 'voltdbclient', '6.8' )
end
