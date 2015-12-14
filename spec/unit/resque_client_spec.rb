require 'spec_helper'

describe ResqueClient do
  let(:redis_client) { Redis::Namespace.new(env, redis: Redis.new(config)) }
  let(:env) { "test" }
  let(:config) do
    {
      db: 2
    }
  end

  subject do
    described_class.new(config, env)
  end

  before do
    redis_client.keys("resque:ClubjudgeBaws:queue*").each do |k|
      redis_client.del(k)
    end
  end

  it 'enqueues a message' do
    subject.enqueue('user_created', user_id: 1)
    actual = redis_client.lrange("resque:ClubjudgeBaws:queue:service_triggers_#{env.upcase}",0,-1)
    expected = [
      "{\"class\":\"ServiceTriggers\",\"args\":[{\"action\":\"user_created\",\"params\":[{\"user_id\":1}]}]}"
    ]
    expect(actual).to eq(expected)
  end

end
