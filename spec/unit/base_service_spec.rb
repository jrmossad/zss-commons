require 'spec_helper'

describe BaseService do

  describe '#ensure_pagination' do
    let(:payload) { Hashie::Mash.new }

    class SomeService < BaseService
      def test_paginated_action(payload)
        ensure_pagination(payload)
      end
    end

    it 'sets pagination to defaults in payload with no pagination' do
      SomeService.new.test_paginated_action(payload)
      expect(payload.page).to eq(BaseService::DEFAULT_FIRST_PAGE)
      expect(payload.per_page).to eq(BaseService::DEFAULT_PAGE_SIZE)
    end

    it 'raises 400 if per page is over limit' do
      payload.per_page = BaseService::DEFAULT_PAGE_LIMIT + 1
      expect{
        SomeService.new.test_paginated_action(payload)
      }.to raise_error(ZSS::Error) do |e|
        expect(e.code).to eq(400)
      end
    end

    it 'accepts incoming page/perPage' do
      payload.page = 2
      payload.per_page = 10
      SomeService.new.test_paginated_action(payload)

      expect(payload.page).to eq(2)
      expect(payload.per_page).to eq(10)
    end
  end

end
