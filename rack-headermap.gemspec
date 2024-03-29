lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack/headermap/version'

Gem::Specification.new do |spec|
  spec.name          = 'rack-headermap'
  spec.version       = Rack::Headermap::VERSION
  spec.authors       = 'Dmitry Vorotilin'
  spec.email         = 'd.vorotilin@gmail.com'
  spec.description   = 'Mount rack applications using nginx proxy_pass'
  spec.summary       = 'Mount rack applications using nginx proxy_pass'
  spec.homepage      = 'https://github.com/route/rack-headermap'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
