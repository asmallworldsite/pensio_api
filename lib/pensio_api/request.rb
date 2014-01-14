module PensioAPI
  class Request
    include HTTParty

    attr_reader :response, :headers, :body
    
    AUTH = {
      username: PensioAPI::Credentials.username,
      password: PensioAPI::Credentials.password
    }

    HEADERS = {
      'Content-Type' => 'application/x-www-form-urlencoded'
    }

    def self.set_base_uri
      self.base_uri PensioAPI::Credentials.base_uri unless self.base_uri
    end

    def initialize(path, options={})
      self.class.set_base_uri
      @response = self.class.post(path, request_options(options))
      @headers = @response.parsed_response['APIResponse']['Header']
      @body = @response.parsed_response['APIResponse']['Body']
    end

    def response_contains?(key)
      @body && @body.has_key?(key)
    end

    private

    def request_options(options)
      {
        basic_auth: AUTH,
        headers: (options.delete(:headers) || {}).merge(HEADERS),
        body: options
      }
    end
  end
end
