# frozen_string_literal: true

require 'set'

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
      }.freeze

      def initialize(path, method: :post, credentials: nil, headers: {}, timeout: nil, **options)
        @method = method
        @credentials = PensioAPI::Credentials.for(credentials.to_sym) unless credentials.nil? || credentials.is_a?(PensioAPI::Credentials)
        @credentials ||= PensioAPI::Credentials.default_credentials if PensioAPI::Credentials.credentials_mode == :default || PensioAPI::Credentials.allow_defaults
        raise Errors::NoCredentials unless @credentials&.supplied?

        @request_headers = headers || {}
        @timeout = timeout

        self.class.base_uri @credentials.base_uri unless self.class.base_uri

        @response = case method
                    when :get
                      self.class.get(path, request_options(params: options))
                    when :post
                      self.class.post(path, request_options(body: options))
                    else
                      raise Errors::Error, "Method #{@method} is not supported"
                    end
      end

      private

      def request_options(body: nil, params: nil)
        {
          basic_auth: auth,
          headers: @request_headers.merge(HEADERS),
          body: body,
          params: params
        }.tap do |request_options|
          request_options[:timeout] = @timeout if @timeout
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
