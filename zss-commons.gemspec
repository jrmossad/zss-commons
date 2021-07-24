lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require './lib/version'

Gem::Specification.new do |spec|
  spec.name          = 'zss-commons'
  spec.version       = ZSS::Commons::VERSION
  spec.authors       = ["Pedro Januário","Francisco Temudo"]
  spec.email         = ["fthemudo@gmail.com"]
  spec.description   = %q{Base DTO classes and pagination}
  spec.summary       = %q{This project is defines the base DTO classes and behaviours for ZMQ Service Suite,
                          check http://pjanuario.github.io/zmq-service-suite-specs/ for more info.}
  spec.homepage      = "https://github.com/Clubjudge/zss-commons"
  spec.metadata      = {
    "source_code" => "git@github.com:jrmossad/zss-commons.git",
    "issue_tracker" => "https://github.com/dadah/zss-commons/issues"
  }

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
end
