module PensioAPI
  module Mixins
    module RequestDefaults
      def self.included(base)
        base.send(:include, HTTParty)
        base.send(:attr_reader, :response)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def set_base_uri
          self.base_uri PensioAPI::Credentials.base_uri unless self.base_uri
        end
      end

      HEADERS = {
        'Content-Type' => 'application/x-www-form-urlencoded; charset=utf-8'
      }

      def initialize(path, options={})
        self.class.set_base_uri

        raise Errors::NoCredentials unless credentials_supplied?

        @response = self.class.post(path, request_options(options))
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
end
