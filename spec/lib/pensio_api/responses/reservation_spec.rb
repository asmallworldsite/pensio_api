require 'spec_helper'

describe PensioAPI::Responses::Reservation do
  before :each do
    stub_pensio_response('/merchant/API/reservation', 'reservation')
  end

  let(:response) { PensioAPI::Reservation.create(reservation_arguments) }

  specify { expect(response).to be_an_instance_of(PensioAPI::Responses::Reservation) }

  describe 'readable attributes' do
    specify { expect(response.charge).to be_an_instance_of(PensioAPI::Transaction) }
    specify { expect(response.reservation).to be_an_instance_of(PensioAPI::Transaction) }
  end
end
