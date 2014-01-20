require 'spec_helper'

describe PensioAPI::Responses::SuccessCallback do

  let(:response) { PensioAPI::Callback.parse_success(file_fixture("success_callback.xml")) }

  it "succeeds" do
    expect(response.success?).to be_true
  end
  
  describe ".reservation" do
    it "gets a reservation transaction" do
      expect(response.reservation).to be_an_instance_of(PensioAPI::Transaction)
      expect(response.reservation).to be_reserved
      expect(response.reservation.reserved_amount).to be > 0.0
      expect(response.reservation.captured_amount).to eq 0.0
    end
  end
  
  describe ".charge" do
    it "gets a charge transaction with capture" do
      expect(response.charge).to be_an_instance_of(PensioAPI::Transaction)
      expect(response.charge).to be_captured
      expect(response.charge.reserved_amount).to eq(response.charge.captured_amount)
      expect(response.charge.reserved_amount).to be > 0.0
      expect(response.charge.captured_amount).to be > 0.0
    end
  end
  
end

