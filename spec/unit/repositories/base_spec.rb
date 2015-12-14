require 'spec_helper'

describe Repository::Base do

  describe '#paginate' do

    let(:query) { double :an_active_record_query }
    let(:limitted_query) { double :another_active_record_query }
    let(:page) { 3 }
    let(:per_page) { 10 }

    class SomeRepository < Repository::Base

      def test_pagination query, page, per_page
        paginate(query, page, per_page)
      end

    end

    it 'paginates a query' do

      expect(query).to receive(:limit).with(per_page).and_return(limitted_query)
      expect(limitted_query).to receive(:offset).with(20)
      SomeRepository.new.test_pagination query, page, per_page

    end

  end

end
