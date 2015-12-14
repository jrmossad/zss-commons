require 'hashie'
module DTO
  class Paginated
    include Enumerable

    attr_reader :data, :pagination

    def initialize(data, total, page, per_page)
      @data = data
      @pagination = Hashie::Mash.new(
        current_page: page,
        per_page:     per_page,
        total_pages:  (total.to_f / per_page).ceil,
        total_items:  total
      )
    end

    def each(&block)
      @data.each(&block)
    end

    def serialize
      {
        data: Array(data).map(&:serialize),
        pagination: @pagination
      }
    end

    def ==(another)
      self.serialize == another.serialize
    end

  end
end
