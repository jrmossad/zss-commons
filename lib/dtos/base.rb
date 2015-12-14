require 'active_support/core_ext/hash/indifferent_access'
module DTO
  class Base

    def initialize params = {}
      return unless params.present?
      indiff_params = params.with_indifferent_access
      indiff_params.each do |k, v|
        instance_variable_set("@#{k}".to_sym, v) if respond_to?(k)
      end
    end

    def serialize
      instance_values.update(instance_values) do |k,v|
        if v.kind_of?(Time) || v.kind_of?(DateTime)
          v.iso8601
        else
          v
        end
      end
    end

    def ==(another)
      return false unless another
      another.is_a?(DTO::Base) && self.serialize == another.serialize
    end

  end
end
