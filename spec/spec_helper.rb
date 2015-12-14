ENV['ZSS_ENV'] ||= 'test'

if ENV['CODECLIMATE_REPO_TOKEN']
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
else
  require 'simplecov'
  SimpleCov.start do
    add_filter '/spec/'
  end
end

require 'rspec'
require 'pry'
require 'active_record'

require 'active_support/core_ext/enumerable'
Dir['./lib/*.rb'].each &method(:require)
Dir['./lib/**/*.rb'].each &method(:require)

RSpec.configure do |config|

  config.before(:each) do
    Redis.new(db: 0).flushdb
  end

end
