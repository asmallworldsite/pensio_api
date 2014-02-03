module PensioAPI
  module Mixins
    module HasTransactions
      def self.included(base)
        base.send(:include, Enumerable)
        base.send(:attr_reader, :transactions)
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
        @raw_transactions ||= if @raw['Transactions']
          @raw['Transactions']['Transaction']
        else
          []
        end
      end
    end
  end
end
