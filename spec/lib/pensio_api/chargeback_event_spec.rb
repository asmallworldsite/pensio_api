require 'spec_helper'

describe PensioAPI::ChargebackEvent do
  let(:response) { PensioAPI::Callback.parse_chargeback(file_fixture("chargeback_callback.xml")) }
  let(:transaction) { response.transactions.last }
  let(:chargeback_event) { transaction.chargeback_events.last }

  describe 'reader attributes' do
    describe 'type' do
      specify { expect(chargeback_event.type).to be_an_instance_of(String) }
    end

    describe 'reason_code' do
      specify { expect(chargeback_event.reason_code).to be_an_instance_of(Integer) }
    end

    describe 'reason' do
      specify { expect(chargeback_event.reason).to be_an_instance_of(String) }
    end

    describe 'amount' do
      specify { expect(chargeback_event.amount).to be_an_instance_of(BigDecimal) }
    end

    describe 'currency' do
      specify { expect(chargeback_event.currency).to be_an_instance_of(String) }
    end

    describe 'acquirer_transaction_id' do
      specify { expect(chargeback_event.acquirer_transaction_id).to be_an_instance_of(String) }
    end
  end

  describe 'created_at' do
    specify { expect(chargeback_event.created_at).to be_an_instance_of(Time) }
  end
end
