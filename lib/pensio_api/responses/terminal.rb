# frozen_string_literal: true

module PensioAPI
  module Responses
    class Terminal < Base
      include Enumerable

      attr_reader :terminals

      def initialize(request)
        super(request)

        map_terminals
      end

      def each
        return enum_for(:each) unless block_given?

        @terminals.each { |t| yield t }
      end

      def last
        @terminals.last
      end

      private

      def map_terminals
        @terminals = if raw_terminals.is_a?(Array)
                       raw_terminals.map { |t| PensioAPI::Terminal.new(t) }.freeze
                     else
                       [PensioAPI::Terminal.new(raw_terminals)].freeze
                     end
      end

      def raw_terminals
        @raw_terminals ||= if @raw['Terminals']
                             @raw['Terminals']['Terminal']
                           else
                             []
                           end
      end
    end
  end
end
