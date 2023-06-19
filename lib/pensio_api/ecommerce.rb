# frozen_string_literal: true

module PensioAPI
  module Ecommerce
    def self.create_payment_request(options = {})
      request = Request.new('/merchant/API/createPaymentRequest', **options)
      Responses::GatewayURL.new(request)
    end

    def self.create_multi_payment_request(options = {})
      request = Request.new('/merchant/API/createMultiPaymentRequest', **options)
      Responses::GatewayURL.new(request)
    end
  end
end
