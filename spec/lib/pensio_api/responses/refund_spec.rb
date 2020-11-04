require 'spec_helper'

describe PensioAPI::Responses::Refund do
  before :each do
    stub_pensio_response('/merchant/API/payments', 'payments')
    stub_pensio_response('/merchant/API/refundCapturedReservation', 'refund_captured_reservation')
  end

  let(:response) { PensioAPI::Transaction.find.first.refund }

  specify { expect(response).to be_an_instance_of(PensioAPI::Responses::Refund) }

  describe 'readable attributes' do
    specify { expect(response.transaction).to be_an_instance_of(PensioAPI::Transaction) }
    specify { expect(response.refund_amount).to eq(BigDecimal('0.12')) }
    specify { expect(response.refund_currency).to eq(978) }
  end
end
