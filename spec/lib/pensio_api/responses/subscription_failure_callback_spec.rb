require 'spec_helper'

describe PensioAPI::Responses::SubscriptionFailureCallback do

  let(:response) { PensioAPI::Callback.parse_failure(file_fixture("subscription_failure_callback.xml")) }

  it "succeeds" do
    expect(response.success?).to be true
  end
  
  describe ".reservation" do
    it "gets a reservation transaction" do
      expect(response.reservation).to be_an_instance_of(PensioAPI::Transaction)
    end
    it "is not reserved" do
      expect(response.reservation).to_not be_reserved
    end
    it "attempted to reserve a non-zero amount" do
      expect(response.reservation.reserved_amount).to be > 0.0
    end
    it "does not capture any amount" do
      expect(response.reservation.captured_amount).to eq 0.0
    end
    it "receives the submitted billing address" do
      expect(response.reservation.billing_address).to be_an_instance_of PensioAPI::BillingAddress
    end
  end
  
  describe ".charge" do
    it "gets a charge transaction" do
      expect(response.charge).to be_an_instance_of(PensioAPI::Transaction)
    end
    it "is not captured" do
      expect(response.reservation).to_not be_captured
    end
    it "does not reserve any amount" do
      expect(response.charge.reserved_amount).to eq 0.0
    end
    it "does not capture any amount" do
      expect(response.charge.captured_amount).to eq 0.0
    end
    it "receives the submitted billing address" do
      expect(response.charge.billing_address).to be_an_instance_of PensioAPI::BillingAddress
    end
  end
  
end

