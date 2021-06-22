module PensioAPI
  module Mixins
    module RequestDefaults
      
      def self.included(base)
        base.send(:include, HTTParty)
        base.send(:attr_reader, :response)
        base.send(:attr_accessor, :credentials)
      end

      HEADERS = {
        'Content-Type' => 'application/x-www-form-urlencoded; charset=utf-8',
        'x-altapay-client-version' => "RUBYSDK/#{PensioAPI::VERSION}"
      }

      def initialize(path, options={})
        @credentials = options.delete(:credentials)
        @credentials = PensioAPI::Credentials.for(@credentials.to_sym) unless @credentials.nil? || @credentials.is_a?(PensioAPI::Credentials)
        @credentials ||= PensioAPI::Credentials.default_credentials if PensioAPI::Credentials.credentials_mode == :default || PensioAPI::Credentials.allow_defaults
        raise Errors::NoCredentials unless @credentials && @credentials.supplied?

        self.class.base_uri @credentials.base_uri unless self.class.base_uri

        @response = self.class.post(path, request_options(options))
      end

      private

      def request_options(options)
        timeout = options.delete(:timeout)
        {
          basic_auth: auth,
          headers: (options.delete(:headers) || {}).merge(HEADERS),
          body: options
        }.tap do |request_options|
          request_options[:timeout] = timeout if timeout
        end
      end

      def auth
        {
          username: @credentials.username,
          password: @credentials.password
        }
      end

    end
  end
end
