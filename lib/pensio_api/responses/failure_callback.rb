module PensioAPI
  module Responses
    class FailureCallback < Transaction
      extend Forwardable

      def_delegators :new, :captured?

      def each
        [reservation, charge].each { |t| yield t }
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
