require 'spec_helper'

describe PensioAPI::Errors::GatewayError do
  before :each do
    stub_pensio_response('/merchant/API/payments', 'pensio_error')
  end

  let(:error) do
    begin
      PensioAPI::Transaction.find
    rescue PensioAPI::Errors::GatewayError => e
    end
    e
  end

  specify { expect(error).to be_an_instance_of PensioAPI::Errors::GatewayError }

  describe 'getter attributes' do
    describe '.request_time' do
      specify { expect(error.request_time).to be_an_instance_of(Time) }
    end

    describe '.request_path' do
      specify { expect(error.request_path).to be_an_instance_of(String) }
    end

    describe '.error_code' do
      specify { expect(error.cardholder_message).to be_an_instance_of(String) }
    end
  end

  describe 'object mapping' do
    it 'maps transactions to transaction objects' do
      expect(error.transactions.all? { |r| r.class == PensioAPI::Transaction }).to be true
    end
  end
end

