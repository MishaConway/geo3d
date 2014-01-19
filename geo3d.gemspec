# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'geo3d/version'

Gem::Specification.new do |spec|
  spec.name          = "geo3d"
  spec.version       = Geo3d::VERSION
  spec.authors       = ["Misha Conway"]
  spec.email         = ["MishaAConway@gmail.com"]
  spec.description   = %q{Library for common 3d graphics vector and matrix operations}
  spec.summary       = %q{Library for common 3d graphics vector and matrix operations}
  spec.homepage      = "https://github.com/MishaConway/geo3d"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "misha-ruby-sdl-ffi"
  spec.add_development_dependency "ruby-opengl"
end
