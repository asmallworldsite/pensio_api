require 'spec_helper'

describe PensioAPI::Transaction do
  before :each do
    stub_pensio_response('/merchant/API/payments', 'payments')
    stub_pensio_response('/merchant/API/getTerminals', 'get_terminals')
    stub_pensio_response('/merchant/API/refundCapturedReservation', 'refund_captured_reservation')
  end

  let(:transaction) { PensioAPI::Transaction.find.first }

  describe 'reader attributes' do
    describe '.captured_amount' do
      specify { expect(transaction.status).to be_an_instance_of(String) }
    end

    describe '.captured_amount' do
      specify { expect(transaction.captured_amount).to be_an_instance_of(BigDecimal) }
    end

    describe '.reserved_amount' do
      specify { expect(transaction.reserved_amount).to be_an_instance_of(BigDecimal) }
    end

    describe '.refunded_amount' do
      specify { expect(transaction.refunded_amount).to be_an_instance_of(BigDecimal) }
    end

    describe '.recurring_default_amount' do
      specify { expect(transaction.recurring_default_amount).to be_an_instance_of(BigDecimal) }
    end

    describe '.merchant_currency' do
      specify { expect(transaction.merchant_currency).to be_an_instance_of(Integer) }
    end

    describe '.card_holder_currency' do
      specify { expect(transaction.card_holder_currency).to be_an_instance_of(Integer) }
    end

    describe '.chargeback_events' do
      specify { expect(transaction.chargeback_events).to be_an_instance_of(Array) }
    end
  end

  describe '.find' do
    describe 'object mapping' do
      let(:response) { PensioAPI::Transaction.find }
      it 'returns an instance of PensioAPI::Responses::Transaction' do
        expect(response).to be_an_instance_of(PensioAPI::Responses::Transaction)
      end

      it 'maps transactions to transaction objects' do
        expect(response.all? { |r| r.class == PensioAPI::Transaction }).to be true
      end

      specify { expect(response.transactions.length).to eq(1) }
    end
  end

  describe '.to_reservation' do
    it 'returns a PensioAPI::Reservation object' do
      expect(transaction.to_reservation).to be_an_instance_of(PensioAPI::Reservation)
    end
  end

  describe '.to_subscription' do
    it 'returns a PensioAPI::Subscription object' do
      expect(transaction.to_subscription).to be_an_instance_of(PensioAPI::Subscription)
    end
  end

  describe '.terminal' do
    it 'returns a PensioAPI::Terminal object' do
      expect(transaction.terminal).to be_an_instance_of(PensioAPI::Terminal)
    end
  end

  describe '.refund' do
    let(:response) { transaction.refund }

    specify { expect(response).to be_an_instance_of(PensioAPI::Responses::Refund) }
  end

  describe '.captured?' do
    context 'when the full reserved amount has been captured' do
      it 'returns true' do
        expect(transaction).to be_captured
      end
    end

    context 'when the full reserved amount has not been captured' do
      it 'returns false' do
        allow(transaction).to receive(:captured_amount).and_return(BigDecimal('0'))
        expect(transaction).to_not be_captured
      end
    end
  end

  describe '.billing_address' do
    it 'returns a PensioAPI::BillingAddress object' do
      expect(transaction.billing_address).to be_an_instance_of(PensioAPI::BillingAddress)
    end
  end
end
