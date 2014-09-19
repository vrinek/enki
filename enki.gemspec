# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'enki/version'

Gem::Specification.new do |spec|
  spec.name          = "enki"
  spec.version       = Enki::VERSION
  spec.authors       = ["Giorgos Avramidis", "Kostas Karachalios"]
  spec.email         = ["avramidg@gmail.com", "vrinek@me.com"]
  spec.summary       = %q{Provide snowcrash and confluence integration}
  spec.description   = %q{}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "qarioz-confluencer", "~> 0.6", '>= 0.6.0'
  spec.add_runtime_dependency "redcarpet", "~> 3.1", ">= 3.1.2"
  spec.add_development_dependency "bundler", "~> 1.6", ">= 1.6.0"
  spec.add_development_dependency "rake", "~> 10.3", ">= 10.3.2"
  spec.add_development_dependency "rspec", "~> 3.0", ">= 3.0.0"
end
