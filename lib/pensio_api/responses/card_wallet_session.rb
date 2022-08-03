module PensioAPI
  module Responses
    class CardWalletSession < Base
      attr_reader :apple_pay_session

      def initialize(request)
        super(request)

        @apple_pay_session = @raw['ApplePaySession']
      end
    end
  end
end
