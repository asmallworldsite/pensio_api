require 'spec_helper'

describe PensioAPI::Responses::SuccessCallback do

  let(:response) { PensioAPI::Callback.parse_success(file_fixture("success_callback.xml")) }

  it "succeeds" do
    expect(response.success?).to be_true
  end
  
  describe ".reservation" do
    it "gets a reservation transaction" do
      expect(response.reservation).to be_an_instance_of(PensioAPI::Transaction)
    end
  end
  
  describe ".charge" do
    it "gets a charge transaction" do
      expect(response.charge).to be_an_instance_of(PensioAPI::Transaction)
    end
  end
  
end

