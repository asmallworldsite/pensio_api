# frozen_string_literal: true

module PensioAPI
  module Errors
    class BadRequest < Error
      attr_reader :request_time, :request_path, :error_code

      def initialize(request)
        super(request.headers['ErrorMessage'])

        @request_time = Time.parse(request.headers['Date'])
        @request_path = request.headers['Path']
        @error_code = request.headers['ErrorCode'].to_i
      end
    end
  end
end
