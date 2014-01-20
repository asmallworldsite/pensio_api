require 'spec_helper'

describe PensioAPI::Responses::FailureCallback do

  let(:response) { PensioAPI::Callback.parse_failure(file_fixture("failure_callback.xml")) }

  it "succeeds" do
    expect(response.success?).to be_true
  end
  
  describe ".reservation" do
    it "gets a reservation transaction" do
      expect(response.reservation).to be_an_instance_of(PensioAPI::Transaction)
      expect(response.reservation.reserved_amount).to be > 0.0
      expect(response.reservation.captured_amount).to eq 0.0
    end
  end
  
  describe ".charge" do
    it "gets a charge transaction without capture" do
      expect(response.charge).to be_an_instance_of(PensioAPI::Transaction)
      expect(response.charge.reserved_amount).to eq 0.0
      expect(response.charge.captured_amount).to eq 0.0
    end
  end
  
end

