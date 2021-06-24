require 'spec_helper'

describe PensioAPI::Errors::BadRequest do
  before :each do
    stub_pensio_response('/merchant/API/payments', 'bad_request_error')
  end

  let(:error) do
    begin
      PensioAPI::Transaction.find
    rescue PensioAPI::Errors::BadRequest => e
    end
    e
  end

  specify { expect(error).to be_an_instance_of PensioAPI::Errors::BadRequest }

  describe 'getter attributes' do
    describe '.request_time' do
      specify { expect(error.request_time).to be_an_instance_of(Time) }
    end

    describe '.request_path' do
      specify { expect(error.request_path).to be_an_instance_of(String) }
    end

    describe '.error_code' do
      specify { expect(error.error_code).to be_an_instance_of(Integer) }
    end
  end
end
