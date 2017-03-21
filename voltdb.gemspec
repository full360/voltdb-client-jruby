# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'voltdb/version'

Gem::Specification.new do |spec|
  spec.name          = "voltdbjruby"
  spec.version       = Voltdb::VERSION
  spec.authors       = ["Alberto Grespan"]
  spec.email         = ["alberto@albertogrespan.com"]

  spec.summary       = %q{JRuby VoltDB client wrapper}
  spec.description   = %q{JRuby VoltDB java client wrapper}
  spec.homepage      = "https://github.com/full360/voltdb-client-jruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency "rspec", "~> 3.5"
  spec.add_development_dependency "jbundler", "~> 0.9"
end
