module PensioAPI
  module Responses
    class Refund < Base
      attr_reader :transaction, :refund_amount, :refund_currency

      def initialize(request)
        super(request)

        @transaction = PensioAPI::Transaction.new(
          transactions['Transaction']
        )
        @refund_amount = BigDecimal(@raw['RefundedAmount'])
        @refund_currency = @raw['RefundCurrency'].to_i
      end
    end
  end
end
