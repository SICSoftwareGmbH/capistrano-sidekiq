# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/sidekiq/version'

Gem::Specification.new do |spec|
  spec.name          = 'capistrano-sidekiq-sic'
  spec.version       = Capistrano::Sidekiq::VERSION
  spec.authors       = ['Florian Schwab']
  spec.email         = ['florian.schwab@sic-software.com']

  spec.summary       = %q{Sidekiq integration for Capistrano}
  spec.description   = %q{Sidekiq integration for Capistrano}
  spec.homepage      = 'https://github.com/SICSoftwareGmbH/capistrano-sidekiq'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'capistrano', '~> 3.4'
  spec.add_dependency 'sidekiq',    '>= 3.0.0', '< 4.0.0'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
end
