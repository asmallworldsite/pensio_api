module PensioAPI
  module Credentials
    class << self
      attr_accessor :base_uri, :username, :password
    end
  end
end
