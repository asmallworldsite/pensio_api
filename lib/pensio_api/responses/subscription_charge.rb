module PensioAPI
  module Responses
    class SubscriptionCharge < Responses::Transaction
      extend Forwardable

      def_delegators :new, :captured?

      def each
        return enum_for(:each) unless block_given?

        yield existing
        yield new
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
