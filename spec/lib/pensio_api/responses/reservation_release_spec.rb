require 'spec_helper'

describe PensioAPI::Responses::ReservationRelease do
  before :each do
    stub_pensio_response('/merchant/API/payments', 'payments', method: :get)
    stub_pensio_response('/merchant/API/releaseReservation', 'release_reservation')
  end

  let(:response) { PensioAPI::Transaction.find.first.to_reservation.release }

  specify { expect(response).to be_an_instance_of(PensioAPI::Responses::ReservationRelease) }
end
