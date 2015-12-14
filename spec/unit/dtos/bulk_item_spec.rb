require 'spec_helper'

describe DTO::Bulk::Item do

  describe '.initialize' do

    it 'fails when data is not paginated' do
      expect {
        described_class.new(1,{})
      }.to raise_error
    end

  end

end
