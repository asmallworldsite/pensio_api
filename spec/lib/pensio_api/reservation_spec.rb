require 'spec_helper'

describe PensioAPI::Reservation do
  before :each do
    stub_pensio_response('/merchant/API/payments', 'payments')
    stub_pensio_response('/merchant/API/captureReservation', 'capture_reservation')
    stub_pensio_response('/merchant/API/releaseReservation', 'release_reservation')
    stub_pensio_response('/merchant/API/reservationOfFixedAmount', 'reservation_of_fixed_amount')
  end

  let(:transaction) { PensioAPI::Transaction.find.first }

  describe '.capture' do
    let(:response) { transaction.to_reservation.capture }

    specify { expect(response).to be_an_instance_of(PensioAPI::Responses::ReservationCapture) }
  end

  describe '.release' do
    let(:response) { transaction.to_reservation.release }

    specify { expect(response).to be_an_instance_of(PensioAPI::Responses::ReservationRelease) }
  end

  describe '.of_fixed_amount' do
    let(:response) do
      PensioAPI::Reservation.of_fixed_amount(reservation_arguments)
    end

    specify { expect(response).to be_an_instance_of(PensioAPI::Responses::Reservation) }
  end
end
