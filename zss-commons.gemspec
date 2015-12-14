lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require './lib/version'

Gem::Specification.new do |spec|
  spec.name          = 'zss-commons'
  spec.version       = ZSS::Commons::VERSION
  spec.authors       = ["Pedro Januário","Francisco Temudo"]
  spec.email         = ["francisco@clubjudge.com"]
  spec.description   = %q{Base DTO classes and pagination}
  spec.summary       = %q{This project is defines the base DTO classes and behaviours for ZMQ Service Suite,
                          check http://pjanuario.github.io/zmq-service-suite-specs/ for more info.}
  spec.homepage      = "https://github.com/Clubjudge/zss-commons"
  spec.metadata      = {
    "source_code" => "https://github.com/Clubjudge/zss-dcommons",
    "issue_tracker" => "https://github.com/Clubjudge/zss-commons/issues"
  }

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake', '~> 10.3'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'pry', '~> 0.10'
  spec.add_development_dependency 'simplecov', '~> 0.9'
  spec.add_development_dependency 'codeclimate-test-reporter', '~> 0.3'
  spec.add_development_dependency 'bump', '~> 0.5'
  spec.add_development_dependency 'activerecord'
  spec.add_dependency 'hashie', '~> 3.2'
  spec.add_dependency 'activesupport', '~> 4.2'
  spec.add_dependency 'zss'
  spec.add_dependency 'redis-namespace'
end
