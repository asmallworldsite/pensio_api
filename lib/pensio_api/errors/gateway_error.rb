module PensioAPI
  module Errors
    class GatewayError < StandardError
      attr_reader :request_time, :request_path, :cardholder_message

      def initialize(request)
        super(request.body['MerchantErrorMessage'])

        @request_time = Time.parse(request.headers['Date'])
        @request_path = request.headers['Path']

        @cardholder_message = request.body['CardHolderErrorMessage']
      end
    end
  end
end
