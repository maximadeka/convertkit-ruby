# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'convertkit/version'

Gem::Specification.new do |spec|
  spec.name          = "convertkit-ruby"
  spec.version       = Convertkit::VERSION
  spec.authors       = ["Manuel Frigerio"]
  spec.email         = ["manuel.frigerio@gmail.com"]

  spec.summary       = %q{A Ruby gem for interacting with the ConvertKit API v3}
  spec.description   = %q{A simple wrapper for the ConvertKit API}
  spec.homepage      = "https://manuel.friger.io"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "dotenv", "~> 2.1"

  spec.add_runtime_dependency "faraday", "~> 1.0"
  spec.add_runtime_dependency "faraday_middleware", "~> 1.0"
  spec.add_runtime_dependency "json", '>= 1.8.3'
end
