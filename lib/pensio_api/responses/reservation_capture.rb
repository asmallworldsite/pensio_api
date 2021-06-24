module PensioAPI
  module Responses
    class ReservationCapture < Base
      attr_reader :transaction, :capture_amount, :capture_currency

      def initialize(request)
        super(request)

        @transaction = PensioAPI::Transaction.new(
          transactions['Transaction']
        )
        @capture_amount = BigDecimal(@raw['CaptureAmount'])
        @capture_currency = @raw['CaptureCurrency'].to_i
      end
    end
  end
end
