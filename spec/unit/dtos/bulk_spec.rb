require 'spec_helper'

describe DTO::Bulk do

  let(:item1) { double :paginated, serialize: { item1_attr: 'item1_val' } }
  let(:item2) { double :paginated, serialize: { item2_attr: 'item2_val' } }
  let(:item3) { double :paginated, serialize: { item3_attr: 'item3_val' } }
  let(:data) do
    [
      DTO::Bulk::Item.new(
        1,
        DTO::Paginated.new([item1, item2], 2, 1, 10)
      ),
      DTO::Bulk::Item.new(
        2,
        DTO::Paginated.new([item3], 1, 1, 10)
      )
    ]
  end
  let(:bulk_item) { described_class.new(data) }

  describe '.initialize' do

    let(:invalid) do
      [ DTO::Bulk::Item.new(1, DTO::Paginated.new), {} ]
    end

    it 'fails if there is an item that is not bulk item' do

      expect {
        described_class.new invalid
      }.to raise_error

    end

  end

  describe '#serialize' do

    it 'serializes all bulk items' do

      expect(bulk_item.serialize).to eq(
        {
          1 => {
            data: [
              {
                item1_attr: 'item1_val'
              },
              {
                item2_attr: 'item2_val'
              }
            ],
            pagination: {
              "current_page" => 1,
              "per_page" => 10,
              "total_pages" => 1,
              "total_items" => 2
            }
          },
          2 => {
            data: [
              {
                item3_attr: 'item3_val'
              }
            ],
            pagination: {
              "current_page" => 1,
              "per_page" => 10,
              "total_pages" => 1,
              "total_items" => 1
            }
          }
        }
      )

    end

  end

  describe '==' do

    let(:item4) { double :paginated, serialize: { item4_attr: 'item1_val' } }
    let(:item5) { double :paginated, serialize: { item5_attr: 'item2_val' } }

    let(:equal_data) do
      [
        DTO::Bulk::Item.new(
          1,
          DTO::Paginated.new([item1, item2], 2, 1, 10)
        ),
        DTO::Bulk::Item.new(
          2,
          DTO::Paginated.new([item3], 1, 1, 10)
        )
      ]
    end
    let(:equal_bulk_item) { described_class.new(data) }

    let(:diff_data) do
      [
        DTO::Bulk::Item.new(
          1,
          DTO::Paginated.new([item4, item5], 2, 1, 10)
        )
      ]
    end
    let(:diff_bulk_item) { described_class.new(diff_data) }

    it 'shows that two bulk items are equal' do

      expect(bulk_item == equal_bulk_item).to be true

    end

    it 'shows that two bulk items are different' do

      expect(bulk_item == diff_bulk_item).to be false

    end

  end

end
