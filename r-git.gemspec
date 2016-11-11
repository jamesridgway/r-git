# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rgit/version'

Gem::Specification.new do |spec|
  spec.name          = 'r-git'
  spec.version       = Rgit::VERSION
  spec.authors       = ['James Ridgway']
  spec.email         = ['myself@james-ridgway.co.uk']

  spec.summary       = 'Executable gem for managing multiple git repositories in a top level directory.'
  spec.description   = 'Executable gem for managing multiple git repositories in a top level directory. r-git allow
                        you to easily fetch, pull, change branch, etc. across multiple git repositories with a single
                        command.'
  spec.homepage      = 'https://github.com/jamesridgway/r-git'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.37'
  spec.add_development_dependency 'simplecov', '~> 0.11'
  spec.add_development_dependency 'codeclimate-test-reporter', '~> 1.0.0'
  spec.add_dependency 'trollop', '~> 2.1.2'
  spec.add_dependency 'git', '~> 1.2.9'
  spec.add_dependency 'colorize', '~> 0.7.7'
end
