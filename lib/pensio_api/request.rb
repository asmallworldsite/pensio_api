module PensioAPI
  class Request
    include HTTParty

    attr_reader :response, :headers, :body

    HEADERS = {
      'Content-Type' => 'application/x-www-form-urlencoded'
    }

    def self.set_base_uri
      self.base_uri PensioAPI::Credentials.base_uri unless self.base_uri
    end

    def initialize(path, options={})
      self.class.set_base_uri

      raise Errors::NoCredentials unless credentials_supplied?

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
        basic_auth: auth,
        headers: (options.delete(:headers) || {}).merge(HEADERS),
        body: options
      }
    end

    def auth
      {
        username: PensioAPI::Credentials.username,
        password: PensioAPI::Credentials.password
      }
    end

    def credentials_supplied?
      Credentials.base_uri && Credentials.username && Credentials.password
    end
  end
end
