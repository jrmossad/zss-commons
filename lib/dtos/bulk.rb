require_relative 'paginated'
module DTO
  class Bulk

    class Item
      attr_reader :data, :id

      def initialize(id, data)
        @data = data
        @id = id
        fail "Type not serializable" unless data.class <= DTO::Paginated
      end
    end

    attr_reader :data

    def initialize(data)
      @data = Array(data)
      invalid = data.select { |i| !i.instance_of? Bulk::Item }.present?
      fail "Invalid item types" if invalid
    end

    def serialize
      return {} unless data.present?

      data.inject({}) { |m,e| m[e.id] = e.data.serialize; m }
    end

    def ==(another)
      self.serialize == another.serialize
    end

  end
end
