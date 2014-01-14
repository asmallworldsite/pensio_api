require 'spec_helper'

describe PensioAPI::Subscription do
  before :each do
    stub_pensio_response('/merchant/API/payments', 'payments')
    stub_pensio_response('/merchant/API/setupSubscription', 'setup_subscription')
    stub_pensio_response('/merchant/API/chargeSubscription', 'charge_subscription')
    stub_pensio_response('/merchant/API/reserveSubscriptionCharge', 'reserve_subscription_charge')
  end

  # Immediate evaluation ensures that expectations receive the right arguments
  let!(:subscription) { PensioAPI::Transaction.find.first.to_subscription }

  describe '.setup' do
    it 'returns an instance of PensioAPI::Transaction' do
      expect(PensioAPI::Subscription.setup(credit_card_token: '1234')).to be_an_instance_of(PensioAPI::Transaction)
    end
  end

  describe '.charge' do
    it 'returns an instance of PensioAPI::Responses::SubscriptionCharge' do
      expect(subscription.charge).to be_an_instance_of(PensioAPI::Responses::SubscriptionCharge)
    end
  end

  describe '.reserve_charge' do
    it 'returns an instance of PensioAPI::Responses::SubscriptionCharge' do
      expect(subscription.reserve_charge).to be_an_instance_of(PensioAPI::Responses::SubscriptionCharge)
    end
  end

  describe 'subscription_options' do
    it 'wraps transaction_id' do
      expect(subscription.send(:subscription_options)[:transaction_id]).to eq('1')
    end
  end
end
