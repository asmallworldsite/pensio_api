module PensioAPI
  module Callback
    FakeRequest = Struct.new(:headers, :body)
 
    def self.parse_success(xml)
      parse(xml, :success)
    end
    
    def self.parse_failure(xml)
      parse(xml, :failure)
    end

    def self.parse_chargeback(xml)
      parse(xml, :chargeback)
    end
    
    private 
    
    def self.parse(xml, handler)
      params = MultiXml.parse(xml)
      
      request = FakeRequest.new(
        params['APIResponse']['Header'],
        params['APIResponse']['Body']
      )
      
      case handler
      when :success
        PensioAPI::Responses::SuccessCallback.new(request)
      when :failure
        PensioAPI::Responses::SubscriptionFailureCallback.new(request)
      when :chargeback
        PensioAPI::Responses::ChargebackCallback.new(request)
      end
    end
  end
end
