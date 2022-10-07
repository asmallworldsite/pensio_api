# frozen_string_literal: true

module PensioAPI
  module Errors
    class GatewayError < Error
      include Mixins::HasTransactions
      attr_reader :request_time, :request_path, :cardholder_message

      def initialize(request)
        super(request.body['MerchantErrorMessage'])

        @raw = request.body

        @request_time = Time.parse(request.headers['Date'])
        @request_path = request.headers['Path']

        @cardholder_message = request.body['CardHolderErrorMessage']

        map_transactions
      end
    end
  end
end
