require 'spec_helper'

describe PensioAPI::Responses::SuccessCallback do

  let(:response) { PensioAPI::Callback.parse_success(file_fixture("success_callback.xml")) }

  it "succeeds" do
    expect(response.success?).to be true
  end
  
  describe ".reservation" do
    it "gets a reservation transaction" do
      expect(response.reservation).to be_an_instance_of(PensioAPI::Transaction)
    end
    it "is reserved" do
      expect(response.reservation).to be_reserved
    end
    it "reserves a non-zero amount" do
      expect(response.reservation.reserved_amount).to be > 0.0
    end
    it "does not capture any amount" do
      expect(response.reservation.captured_amount).to eq 0.0
    end
  end
  
  describe ".charge" do
    it "gets a charge transaction" do
      expect(response.charge).to be_an_instance_of(PensioAPI::Transaction)
    end
    it "is captured" do
      expect(response.charge).to be_captured
    end
    it "reserves a non-zero amount" do
      expect(response.charge.reserved_amount).to be > 0.0
    end
    it "captures a non-zero amount" do
      expect(response.charge.captured_amount).to be > 0.0
    end
    it "captures the same amount as was reserved" do
      expect(response.charge.reserved_amount).to eq(response.charge.captured_amount)
    end
  end
  
end

