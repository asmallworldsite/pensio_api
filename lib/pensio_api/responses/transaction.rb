module PensioAPI
  module Responses
    class Transaction < Base
      include Enumerable

      attr_reader :transactions

      def initialize(request)
        super(request)

        map_transactions
      end

      def each
        @transactions.each { |t| yield t }
      end

      def last
        @transactions.last
      end

      private

      def map_transactions
        @transactions = if raw_transactions.is_a?(Array)
          raw_transactions.map { |t| PensioAPI::Transaction.new(t) }
        else
          [PensioAPI::Transaction.new(raw_transactions)]
        end
      end

      def raw_transactions
        @raw_transactions ||= @raw['Transactions']['Transaction']
      end
    end
  end
end
