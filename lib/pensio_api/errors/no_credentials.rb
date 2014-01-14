module PensioAPI
  module Errors
    class NoCredentials < StandardError
      def initialize
        super('Incomplete credentials were supplied')
      end
    end
  end
end
