# frozen_string_literal: true

module PensioAPI
  module Responses
    class FundingList < Base
      attr_reader :funding_lists, :page_count

      include Enumerable

      def initialize(request)
        super(request)

        map_funding_lists

        @page_count = Integer(@raw.dig('Fundings', 'numberOfPages') || 0)
      end

      def each
        return enum_for(:each) unless block_given?

        @funding_lists.each { |fl| yield fl }
      end

      private

      def map_funding_lists
        @funding_lists = if raw_funding_lists.is_a?(Array)
                           raw_funding_lists.map { |fl| PensioAPI::FundingList.new(fl) }.freeze
                         else
                           [PensioAPI::FundingList.new(raw_funding_lists)].freeze
                         end
      end

      def raw_funding_lists
        @raw_funding_lists ||= if @raw['Fundings'] && raw['Fundings']['Funding']
                                 @raw['Fundings']['Funding']
                               else
                                 []
                               end
      end
    end
  end
end
