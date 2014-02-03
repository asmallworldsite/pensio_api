module PensioAPI
  module Responses
    class Transaction < Base
      include Mixins::HasTransactions

      def initialize(request)
        super(request)

        map_transactions
      end
    end
  end
end
