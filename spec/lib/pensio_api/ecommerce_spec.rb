require 'spec_helper'

describe PensioAPI::Ecommerce do
  before :each do
    stub_pensio_response('/merchant/API/createPaymentRequest', 'create_payment_request')
    stub_pensio_response('/merchant/API/createMultiPaymentRequest', 'create_multi_payment_request')
  end

  describe '.create_payment_request' do
    let(:response) { PensioAPI::Ecommerce.create_payment_request(reservation_arguments) }
    it 'returns an instance of PensioAPI::Responses::GatewayURL' do
      expect(response).to be_an_instance_of(PensioAPI::Responses::GatewayURL)
    end
  end

  describe '.create_multi_payment_request' do
    let(:response) { PensioAPI::Ecommerce.create_multi_payment_request(reservation_arguments) }
    it 'returns an instance of PensioAPI::Responses::GatewayURL' do
      expect(response).to be_an_instance_of(PensioAPI::Responses::GatewayURL)
    end
  end
end
