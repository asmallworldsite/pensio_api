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
    attr_reader :payment_source
    attr_reader :chargeback_events

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

      @captured_amount = BigDecimal(@raw['CapturedAmount'])
      @reserved_amount = BigDecimal(@raw['ReservedAmount'])
      @refunded_amount = BigDecimal(@raw['RefundedAmount'])
      @recurring_default_amount = BigDecimal(@raw['RecurringDefaultAmount'])

      @card_status = @raw['CardStatus']
      @card_token = @raw['CreditCardToken']
      @card_masked_pan = @raw['CreditCardMaskedPan']

      @order_id = @raw['ShopOrderId']

      @merchant_currency = @raw['MerchantCurrency'].to_i
      @card_holder_currency = @raw['CardHolderCurrency'].to_i

      @payment_source = @raw['PaymentSource']

      map_chargeback_events
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

    def refund(options={})
      request = Request.new('/merchant/API/refundCapturedReservation', options.merge(transaction_id: self.id))
      Responses::Refund.new(request)
    end

    def terminal
      @terminal ||= Terminal.all.find { |t| t.title == @raw['Terminal'] }
    end

    def billing_address
      @billing_address ||= if @raw.has_key?('CustomerInfo') && @raw['CustomerInfo'].has_key?('BillingAddress')
        BillingAddress.new(@raw['CustomerInfo']['BillingAddress'])
      end
    end

    private
      
    def map_chargeback_events
      @chargeback_events = if raw_chargeback_events.is_a?(Array)
        raw_chargeback_events.map { |c| PensioAPI::ChargebackEvent.new(c) }
      else
        [PensioAPI::ChargebackEvent.new(raw_chargeback_events)]
      end
    end

    def raw_chargeback_events
      @raw_chargeback_events ||= if @raw['ChargebackEvents']
        @raw['ChargebackEvents']['ChargebackEvent']
      else
        []
      end
    end
  end
end
