module PensioAPI
  module Mixins
    module MethodMissing
      def method_missing(method, *args, **kwargs, &block)
        attribute = camelify(method)

        if @raw.key?(attribute)
          @raw[attribute]
        else
          super
        end
      end

      def respond_to_missing?(method, include_private = false)
        @raw[camelify(method)].nil? || super
      end

      def camelify(method_name)
        String(method_name).split('_').map(&:capitalize).join
      end
    end
  end
end
