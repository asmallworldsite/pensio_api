require 'csv'

module PensioAPI
  class FundingListRequest
    include Mixins::RequestDefaults

    attr_reader :result

    def initialize(path, options={})
      super(path, options)

      @result = CSV.parse(@response.body, col_sep: ';', headers: true).reject(&:empty?)
    end
  end
end
