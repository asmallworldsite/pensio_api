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
      
      def transaction
        puts "DEPRECATION WARNING: PensioAPI::Responses::Reservation#transaction is deprecated - use #charge instead"
        charge  
      end

    end
  end
end
