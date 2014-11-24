module PensioAPI
  module Responses
    class ReservationRelease < Base
      attr_reader :transaction

      def initialize(request)
        super(request)

        @transaction = PensioAPI::Transaction.new(
          transactions['Transaction']
        )
      end
    end
  end
end
