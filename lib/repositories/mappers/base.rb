module Mapper

  class Base
    class << self

      def map(instance)
        return nil unless instance

        return to_dto(instance) if instance.kind_of? ActiveRecord::Base
        return to_dao(instance)
      end

      def to_dto(instance)
        raise NotImplementedError.new('You must implement to_dto in your subclass')
      end

      def to_dao(instance)
        raise NotImplementedError.new('You must implement to_dao in your subclass')
      end

    end
  end

end
