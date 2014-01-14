module PensioAPI
  module Responses
    class ReservationCapture < Responses::Reservation
      attr_reader :capture_amount, :capture_currency

      def initialize(request)
        super(request)

        @capture_amount = BigDecimal.new(@raw['CaptureAmount'])
        @capture_currency = @raw['CaptureCurrency'].to_i
      end
    end
  end
end
