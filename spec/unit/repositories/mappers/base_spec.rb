require 'spec_helper'

describe Mapper::Base do

  describe '.map' do

    let(:mock_ar) { double :active_record_instance, kind_of?: true}

    it 'maps to nil if no instance is given' do

      expect(described_class.map(nil)).to be_nil

    end

    it 'calls to_dto if instance is active record' do

      expect(described_class).to receive(:to_dto)
      described_class.map(mock_ar)

    end

    it 'calls to_dao if instance is not active record' do

      expect(described_class).to receive(:to_dao)
      described_class.map({})

    end

  end

  describe '.to_dto' do

    it 'raises not implemented error' do

      expect {
        described_class.to_dto({})
      }.to raise_error(NotImplementedError)

    end

  end

  describe '.to_dao' do

    it 'raises not implemented error' do

      expect {
        described_class.to_dao({})
      }.to raise_error(NotImplementedError)

    end

  end

end
