# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'scamp/bc3/version'

Gem::Specification.new do |spec|
  spec.name          = "scamp-bc3"
  spec.version       = Scamp::Bc3::VERSION
  spec.authors       = ["Will Jessop"]
  spec.email         = ["will@willj.net"]

  spec.summary       = %q{BC3 adapter for Scamp}
  spec.description   = %q{BC3 adapter for Scamp}
  spec.homepage      = "https://github.com/wjessop/scamp-bc3"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency "scamp", "2.0.0.pre"
end
