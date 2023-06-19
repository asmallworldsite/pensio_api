# frozen_string_literal: true

module PensioAPI
  class Request
    include Mixins::RequestDefaults

    attr_reader :headers, :body

    def initialize(path, **options)
      super(path, **options)

      @headers = @response.parsed_response['APIResponse']['Header']
      @body = @response.parsed_response['APIResponse']['Body']
    end

    def response_contains?(key)
      !!@body && @body.key?(key)
    end
  end
end
