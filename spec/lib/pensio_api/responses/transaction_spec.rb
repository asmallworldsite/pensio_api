require 'spec_helper'

describe PensioAPI::Responses::Transaction do
  before :each do
    stub_pensio_response('/merchant/API/payments', 'payments')
  end

  let(:response) { PensioAPI::Transaction.find }

  describe 'object mapping' do
    it 'maps transactions to transaction objects' do
      expect(response.transactions.all? { |r| r.class == PensioAPI::Transaction }).to be true
    end

    specify { expect(response.transactions.length).to eq(1) }

    describe '.map_transactions' do
      context 'with one transaction' do

        specify { expect(response.transactions.length).to eq(1) }
        specify { expect(response.transactions.map(&:class)).to eq([PensioAPI::Transaction]) }

        it 'returns the transaction inside an array' do
          expect(response.transactions).to be_an_instance_of(Array)
        end
      end

      context 'with more than one transaction' do
        before :each do
          stub_pensio_response('/merchant/API/payments', 'multiple_payments')
        end

        let(:response) { PensioAPI::Transaction.find }

        specify { expect(response.transactions.length).to eq(2) }
        specify { expect(response.transactions.map(&:class).uniq).to eq([PensioAPI::Transaction]) }

        it 'returns an array' do
          expect(response.transactions).to be_an_instance_of(Array)
        end
      end
    end
  end

  context 'with no payments' do
    before :each do
      stub_pensio_response('/merchant/API/payments', 'payments_none')
    end

    describe '.transactions' do
      it 'returns an empty array' do
        expect(response.transactions).to eq([])
      end
    end
  end
end
