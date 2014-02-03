module PensioAPI
  module Callback
    FakeRequest = Struct.new(:headers, :body)
 
    def self.parse_success(xml)
      parse(xml, true)
    end
    
    def self.parse_failure(xml)
      parse(xml, false)
    end
    
    private 
    
    def self.parse(xml, success)
      params = MultiXml.parse(xml)
      
      request = FakeRequest.new(
        params['APIResponse']['Header'],
        params['APIResponse']['Body']
      )
      
      if success
        PensioAPI::Responses::SuccessCallback.new(request)
      else
        PensioAPI::Responses::SubscriptionFailureCallback.new(request)
      end
    end
  end
end