require 'spec_helper'

describe DTO::Base do

  let(:payload) do
    {
      first_attr: 'somestring',
      second_attr: 33,
      third_attr: 'thisshouldnotbeset'
    }
  end

  let(:time_payload) do
    {
      datetime: DateTime.parse("2010-01-01 09:00:00").utc,
      time: Time.parse("2014-10-01 23:58:10").utc
    }
  end

  class SomeDTO < DTO::Base
    attr_accessor :first_attr, :second_attr
  end

  class SomeDTOWithTimes < DTO::Base
    attr_accessor :datetime, :time
  end

  let(:some_dto_instance) { SomeDTO.new(payload) }
  let(:some_dto_instance_with_times) { SomeDTOWithTimes.new(time_payload) }

  describe '.initialize' do

    it 'initializes the existing attributes only' do

      expect(some_dto_instance.first_attr).to eq(payload[:first_attr])
      expect(some_dto_instance.second_attr).to eq(payload[:second_attr])

    end

    it 'does not initialize non existing attributes' do

      expect{
        some_dto_instance.third_attr
      }.to raise_error(NoMethodError)

    end

  end

  describe '#serialize' do

    it 'returns the instance values' do

      expect(some_dto_instance.serialize).to eq(
        {
          "first_attr" => 'somestring',
          "second_attr" => 33
        }
      )

    end

    it 'converts datetime and time to iso8601' do
      expect(
        some_dto_instance_with_times.serialize
      ).to eq(
        {
          "datetime" => time_payload[:datetime].iso8601,
          "time" => time_payload[:time].iso8601
        }
      )
    end

  end

  describe '#==' do

    let(:diff_payload) do
      {
        first_attr: 1,
        second_attr: 'someotherstring'
      }
    end
    let(:equal_dto_instance) { SomeDTO.new(payload) }
    let(:different_dto_instance) { SomeDTO.new(diff_payload) }

    it 'shows that dtos are equal when they are equal' do
      expect(
        some_dto_instance == equal_dto_instance
      ).to be true
    end

    it 'shows that dtos are different when they are different' do
      expect(
        some_dto_instance == different_dto_instance
      ).to be false
    end

    it 'shows that dtos are different is nil' do
      expect(some_dto_instance == nil).to be false
    end

    it 'shows that dtos are different when type is not the same' do
      expect(some_dto_instance == {other_type: true}).to be false
    end

  end

end
