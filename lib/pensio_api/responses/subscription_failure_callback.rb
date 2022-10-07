module PensioAPI
  module Responses
    class SubscriptionFailureCallback < Transaction
      extend Forwardable

      def_delegators :new, :captured?

      def each
        return enum_for(:each) unless block_given?

        yield reservation
        yield charge
      end

      def reservation
        @transactions.first
      end

      def charge
        @transactions.last
      end
    end
  end
end
