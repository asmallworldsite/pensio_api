module PensioAPI
  class ChargebackEvent
    attr_reader :type
    attr_reader :reason_code
    attr_reader :reason
    attr_reader :amount
    attr_reader :currency
    attr_reader :acquirer_transaction_id

    def initialize(chargeback_body)
      @raw = chargeback_body

      @type = @raw['Type']
      @reason_code = @raw['ReasonCode'].to_i
      @reason = @raw['Reason']
      @amount = BigDecimal(@raw['Amount'])
      @currency = @raw['Currency']
      @acquirer_transaction_id = @raw['AcquirerTransactionId']
    end

    def created_at
      @created_at ||= Time.parse(@raw['Date'])
    end
  end
end
