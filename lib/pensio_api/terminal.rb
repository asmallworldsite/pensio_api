module PensioAPI
  class Terminal
    include Mixins::MethodMissing

    attr_reader :title
    attr_reader :country
    attr_reader :natures
    attr_reader :currencies
    attr_reader :terminal_methods

    def self.all
      request = Request.new('/merchant/API/getTerminals')
      Responses::Terminal.new(request)
    end

    def initialize(terminal_body)
      @raw = terminal_body
      @title = @raw['Title']
      @country = @raw['Country'] rescue nil
      @natures = @raw['Natures']['Nature'] rescue []
      @currencies = @raw['Currencies']['Currency'] rescue []
      @terminal_methods = @raw['Methods']['Method'] rescue []
    end
  end
end
