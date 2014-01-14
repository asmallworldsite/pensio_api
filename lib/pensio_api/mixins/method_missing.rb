module PensioAPI
  module Mixins
    module MethodMissing
      def method_missing(method, *args, &block)
        @raw[method.to_s.camelize] || super
      end
    end
  end
end
