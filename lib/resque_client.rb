require 'redis'
require 'redis-namespace'
class ResqueClient

  attr_reader :redis, :env

  def initialize(config = {}, env)
    @env = env
    @redis ||= begin
      client = Redis.new config
      Redis::Namespace.new env, redis: client
    end
  end

  def enqueue action, *args
    add_queue unless queue_exists?
    redis.rpush queue, {
      class: 'ServiceTriggers',
      args: [{
        action: action,
        params: args
      }]
    }.to_json
  end

  private

  def add_queue
    redis.sadd "resque:ClubjudgeBaws:queues", "service_triggers_#{env.upcase}"
  end

  def queue_exists?
    members = redis.smembers "resque:ClubjudgeBaws:queues"
    members.include? "service_triggers_#{env.upcase}"
  end

  def queue
    @queue ||= "resque:ClubjudgeBaws:queue:service_triggers_#{env.upcase}"
  end
end
