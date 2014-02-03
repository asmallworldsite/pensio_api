require 'spec_helper'

describe PensioAPI::Callback do

  describe ".parse_success" do
    let(:response) { PensioAPI::Callback.parse_success(file_fixture("success_callback.xml")) }
    it "should return a SuccessCallback response" do
      expect(response).to be_an_instance_of(PensioAPI::Responses::SuccessCallback)
      expect(response.success?).to be_true
    end
  end
  
  describe ".parse_failure" do 
    let(:response) { PensioAPI::Callback.parse_failure(file_fixture("subscription_failure_callback.xml")) }
    it "should return a SubscriptionFailureCallback response" do
      expect(response).to be_an_instance_of(PensioAPI::Responses::SubscriptionFailureCallback)
      expect(response.success?).to be_true
    end
  end
end

