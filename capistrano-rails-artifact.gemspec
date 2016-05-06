# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano-rails-artifact/version'

Gem::Specification.new do |spec|
  spec.name          = "capistrano-rails-artifact"
  spec.version       = CapistranoRailsArtifact::VERSION
  spec.authors       = ["Case Taintor"]
  spec.email         = ["case.taintor@klarna.com"]
  spec.summary       = %q{A gem to allow you to deploy using a .tar.gz or .xz}
  spec.description   = %q{A gem to allow you to deploy using a .tar.gz or .xz}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake"

  spec.add_dependency "capistrano", "~> 3.0"
end
