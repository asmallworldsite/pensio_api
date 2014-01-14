module PensioAPI
  module Responses
    class Reservation < Base
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
