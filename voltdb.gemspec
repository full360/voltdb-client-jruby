# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'voltdb/version'

Gem::Specification.new do |spec|
  spec.name          = "voltdbjruby"
  spec.version       = Voltdb::VERSION
  spec.authors       = ["Alberto Grespan"]
  spec.email         = ["alberto@albertogrespan.com"]

  spec.summary       = %q{JRuby VoltDB Client}
  spec.description   = %q{A thin wrapper around the VoltDB Java client}
  spec.homepage      = "https://github.com/full360/voltdb-client-jruby"
  spec.license       = "MIT"

  # This is important to get the jars installed
  spec.platform      = "java"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(examples|test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.requirements << "jar org.voltdb, voltdbclient, 6.8"

  spec.add_development_dependency "jar-dependencies", "~> 0.3"
  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 12"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency "rspec", "~> 3.5"
end
