require 'spec_helper'

describe PensioAPI::BillingAddress do
  before :each do
    stub_pensio_response('/merchant/API/payments', 'payments')
  end

  let(:transaction) { PensioAPI::Transaction.find.first }
  let(:billing_address) { transaction.billing_address }

  describe 'reader attributes' do
    describe '.first_name' do
      specify { expect(billing_address.first_name).to eq(transaction.customer_info['BillingAddress']['Firstname']) }
    end

    describe '.last_name' do
      specify { expect(billing_address.last_name).to eq(transaction.customer_info['BillingAddress']['Lastname']) }
    end

    describe '.street_address' do
      specify { expect(billing_address.street_address).to eq(transaction.customer_info['BillingAddress']['Address']) }
    end

    describe '.city' do
      specify { expect(billing_address.city).to eq(transaction.customer_info['BillingAddress']['City']) }
    end

    describe '.postal_code' do
      specify { expect(billing_address.postal_code).to eq(transaction.customer_info['BillingAddress']['PostalCode']) }
    end

    describe '.country' do
      specify { expect(billing_address.country).to eq(transaction.customer_info['BillingAddress']['Country']) }
    end
  end
end
