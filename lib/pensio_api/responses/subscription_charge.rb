module PensioAPI
  module Responses
    class SubscriptionCharge < Responses::Transaction
      extend Forwardable

      def_delegators :new, :captured?

      def each
        [existing, new].each { |t| yield t }
      end

      def existing
        @transactions.first
      end

      def new
        @transactions.last
      end
    end
  end
end
