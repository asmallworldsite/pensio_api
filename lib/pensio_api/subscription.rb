# frozen_string_literal: true

module PensioAPI
  class Subscription
    def self.setup(options = {})
      request = Request.new('/merchant/API/setupSubscription', options)
      if request.response_contains?('Transactions')
        Transaction.new(request.body['Transactions']['Transaction'])
      end
    end

    def initialize(transaction)
      @transaction = transaction
    end

    def charge(options = {})
      request = Request.new('/merchant/API/chargeSubscription', options.merge(subscription_options))
      Responses::SubscriptionCharge.new(request)
    end

    def reserve_charge(options = {})
      request = Request.new('/merchant/API/reserveSubscriptionCharge', options.merge(subscription_options))
      Responses::SubscriptionCharge.new(request)
    end

    private

    def subscription_options
      { transaction_id: @transaction.id }
    end
  end
end
