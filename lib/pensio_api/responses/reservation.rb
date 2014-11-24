module PensioAPI
  module Responses
    class Reservation < Transaction

      def each
        [reservation, charge].each { |t| yield t }
      end

      def reservation
        @transactions.first
      end

      def charge
        @transactions.last
      end
      
    end
  end
end
