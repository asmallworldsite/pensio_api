require 'spec_helper'

describe PensioAPI::Responses::SubscriptionCharge do
  before :each do
    stub_pensio_response('/merchant/API/payments', 'payments')
    stub_pensio_response('/merchant/API/chargeSubscription', 'charge_subscription')
    stub_pensio_response('/merchant/API/reserveSubscriptionCharge', 'reserve_subscription_charge')
  end

  let(:response) { PensioAPI::Transaction.find.first.to_subscription.charge }
  let(:uncharged_response) { PensioAPI::Transaction.find.first.to_subscription.reserve_charge }

  specify { expect(response).to be_an_instance_of(PensioAPI::Responses::SubscriptionCharge) }

  describe '.existing' do
    specify { expect(response.existing).to be_an_instance_of(PensioAPI::Transaction) }
  end

  describe '.new' do
    specify { expect(response.new).to be_an_instance_of(PensioAPI::Transaction) }
  end

  describe '.each' do
    let(:enumerator) { response.to_enum }

    specify { expect(enumerator.count).to eq(2) }

    it 'yields the existing transaction first' do
      expect(enumerator.next).to eq(response.existing)
    end

    it 'yields the new transaction second' do
      enumerator.next
      expect(enumerator.next).to eq(response.new)
    end
  end

  describe '.captured?' do
    it 'delegates .captured? to the new transaction' do
      expect(response).to receive(:captured?)
      response.captured?
    end

    context 'with a reserved charge' do
      it 'returns false' do
        expect(uncharged_response).to_not be_captured
      end
    end

    context 'with a captured charge' do
      it 'returns true' do
        expect(response).to be_captured
      end
    end
  end
end
