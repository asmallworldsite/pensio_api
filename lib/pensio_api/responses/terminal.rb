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
        @terminals.each { |t| yield t }
      end

      def last
        @terminals.last
      end

      private

      def map_terminals
        @terminals = if raw_terminals.is_a?(Array)
          raw_terminals.map { |t| PensioAPI::Terminal.new(t) }
        else
          [PensioAPI::Terminal.new(raw_terminals)]
        end
      end

      def raw_terminals
        @raw_terminals ||= @raw['Terminals']['Terminal']
      end
    end
  end
end
