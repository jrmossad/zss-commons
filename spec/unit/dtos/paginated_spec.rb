require 'spec_helper'

describe DTO::Paginated do
  let(:data) do
    values = []
    2.times { |i| values << Hashie::Mash.new(serialize: i, num: 1) }
    values
  end

  subject do
    described_class.new(data, 10, 1, 2)
  end

  describe '.each' do
    it 'iterates over data' do
      expect(subject.map(&:num).sum).to eq(2)
    end
  end

  describe '.serialize' do
    it 'iterates over data' do
      expect(subject.serialize).to eq({
        data: [0,1],
        pagination: {
          current_page: 1,
          per_page:     2,
          total_pages:  5,
          total_items:  10
        }.with_indifferent_access
      })
    end
  end

  describe '.initialize' do
    it 'returns number of pages' do
      subject = described_class.new(data, 2, 1, 2)
      expect(subject.pagination.total_pages).to eq(1)
    end

    it 'returns number of pages ceiled' do
      subject = described_class.new(data, 3, 1, 2)
      expect(subject.pagination.total_pages).to eq(2)
    end
  end

  describe '.==' do
    it 'should be equal' do
      expect(subject).to eq(subject)
    end

    it 'should not be equal' do
      other = described_class.new(data, 3, 1, 2)
      expect(subject).not_to eq(other)
    end
  end

end
