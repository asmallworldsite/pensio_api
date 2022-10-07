# frozen_string_literal: true

module PensioAPI
  class FundingList
    attr_reader :filename
    attr_reader :amount
    attr_reader :acquirer
    attr_reader :funding_date
    attr_reader :created_at
    attr_reader :download_link

    def self.all(options = {})
      request = Request.new('/merchant/API/fundingList', options)
      Responses::FundingList.new(request)
    end

    def initialize(funding_list_body)
      @raw = funding_list_body

      @filename = @raw['Filename']
      @amount = @raw['Amount']
      @acquirer = @raw['Acquirer']
      @funding_date = Date.parse(@raw['FundingDate'])
      @created_at = Date.parse(@raw['CreatedDate'])
      @download_link = @raw['DownloadLink'].strip
    end

    def download(options = {})
      @download ||= FundingListRequest.new(@download_link, options).result
    end
  end
end
