require 'spec_helper'

describe PensioAPI::Responses::ReservationCapture do
  before :each do
    stub_pensio_response('/merchant/API/payments', 'payments')
    stub_pensio_response('/merchant/API/captureReservation', 'capture_reservation')
  end

  let(:response) { PensioAPI::Transaction.find.first.to_reservation.capture }

  specify { expect(response).to be_an_instance_of(PensioAPI::Responses::ReservationCapture) }

  describe 'readable attributes' do
    specify { expect(response.transaction).to be_an_instance_of(PensioAPI::Transaction) }
    specify { expect(response.capture_amount).to eq(BigDecimal('0.20')) }
    specify { expect(response.capture_currency).to eq(978) }
  end
end
