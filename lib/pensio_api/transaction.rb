module PensioAPI
  class Transaction
    include Mixins::ID
    include Mixins::MethodMissing
    include Mixins::Timestamps

    attr_reader :status
    attr_reader :captured_amount
    attr_reader :reserved_amount
    attr_reader :refunded_amount
    attr_reader :recurring_default_amount
    attr_reader :card_status
    attr_reader :card_token
    attr_reader :card_masked_pan
    attr_reader :order_id
    attr_reader :merchant_currency
    attr_reader :card_holder_currency

    # constants for transaction statuses
    STATUS_RECURRING_CONFIRMED = 'recurring_confirmed'
    STATUS_RELEASED = 'released'
    STATUS_CAPTURED = 'captured'
    STATUS_CAPTURED_FAILED = 'captured_failed'
    
    RESERVATION_SUCCESS_STATUSES = [STATUS_RECURRING_CONFIRMED]
    CHARGE_SUCCESS_STATUSES = [STATUS_CAPTURED]
    
    def initialize(transaction_body)
      @raw = transaction_body

      @status = @raw['TransactionStatus']

      @captured_amount = BigDecimal.new(@raw['CapturedAmount'])
      @reserved_amount = BigDecimal.new(@raw['ReservedAmount'])
      @refunded_amount = BigDecimal.new(@raw['RefundedAmount'])
      @recurring_default_amount = BigDecimal.new(@raw['RecurringDefaultAmount'])

      @card_status = @raw['CardStatus']
      @card_token = @raw['CreditCardToken']
      @card_masked_pan = @raw['CreditCardMaskedPan']

      @order_id = @raw['ShopOrderId']

      @merchant_currency = @raw['MerchantCurrency'].to_i
      @card_holder_currency = @raw['CardHolderCurrency'].to_i
    end

    def self.find(options={})
      request = Request.new('/merchant/API/payments', options)
      Responses::Transaction.new(request)
    end

    def captured?
      captured_amount >= reserved_amount && CHARGE_SUCCESS_STATUSES.include?(self.transaction_status)
    end
    
    def reserved?
      RESERVATION_SUCCESS_STATUSES.include?(self.transaction_status)
    end

    def to_reservation
      Reservation.new(self)
    end

    def to_subscription
      Subscription.new(self)
    end

    def terminal
      @terminal ||= Terminal.all.find { |t| t.title == @raw['Terminal'] }
    end

    def billing_address
      @billing_address ||= if @raw.has_key?('CustomerInfo')
        BillingAddress.new(@raw['CustomerInfo']['BillingAddress'])
      end
    end
  end
end
