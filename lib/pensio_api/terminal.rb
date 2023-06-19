# frozen_string_literal: true

module PensioAPI
  class Terminal
    include Mixins::MethodMissing

    attr_reader :title

    def self.all
      request = Request.new('/merchant/API/getTerminals', method: :get)
      Responses::Terminal.new(request)
    end

    def initialize(terminal_body)
      @raw = terminal_body
      @title = @raw['Title']
    end
  end
end
