require 'spec_helper'

describe PensioAPI::Responses::GatewayURL do
  before :each do
    stub_pensio_response('/merchant/API/createPaymentRequest', 'create_payment_request')
  end

  let (:gateway_url_response) { PensioAPI::Ecommerce.create_payment_request(reservation_arguments) }

  describe 'getter attributes' do
    describe '.url' do
      it 'exposes the URL' do
        expect(gateway_url_response.url).to eq(gateway_url_response.raw['Url'])
      end
    end
  end
end
