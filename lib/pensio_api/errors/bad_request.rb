module PensioAPI
  module Errors
    class BadRequest < StandardError
      attr_reader :request_time, :request_path, :error_code

      def initialize(request)
        super(request.headers['ErrorMessage'])

        @request_time = Time.parse(request.headers['Date'])
        @request_path = request.headers['Path']
        @error_code = request.headers['ErrorCode']
      end
    end
  end
end
