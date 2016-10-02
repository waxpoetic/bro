# coding: utf-8
# frozen_string_literal: true
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bro/version'

Gem::Specification.new do |spec|
  spec.name          = 'bro'
  spec.version       = Bro::VERSION
  spec.authors       = ['Tom Scott']
  spec.email         = ['tscott@weblinc.com']

  spec.summary       = 'basecamp chatbot for brother.ly'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/waxpoetic/bro'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'sinatra'
  spec.add_dependency 'activesupport', '~> 5.0'
  spec.add_dependency 'activemodel', '~> 5.0'
  spec.add_dependency 'puma'

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'foreman'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rack-test'
end
