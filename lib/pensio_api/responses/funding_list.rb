module PensioAPI
  module Responses
    class FundingList < Base
      attr_reader :funding_lists

      include Enumerable

      def initialize(request)
        super(request)

        map_funding_lists
      end

      def each
        @funding_lists.each { |fl| yield fl }
      end

      private

      def map_funding_lists
        @funding_lists = if raw_funding_lists.is_a?(Array)
          raw_funding_lists.map { |fl| PensioAPI::FundingList.new(fl) }
        else
          [PensioAPI::FundingList.new(raw_funding_lists)]
        end
      end

      def raw_funding_lists
        @raw_funding_lists ||= if @raw['Fundings']
          @raw['Fundings']['Funding']
        else
          []
        end
      end
    end
  end
end
