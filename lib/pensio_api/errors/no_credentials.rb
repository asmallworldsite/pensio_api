# frozen_string_literal: true

module PensioAPI
  module Errors
    class NoCredentials < Error
      def initialize
        super('Incomplete credentials were supplied')
      end
    end
  end
end
