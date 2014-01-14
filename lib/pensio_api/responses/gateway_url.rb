module PensioAPI
  module Responses
    class GatewayURL < Base
      attr_reader :url

      def initialize(request)
        super(request)

        @url = @raw['Url']
      end
    end
  end
end
