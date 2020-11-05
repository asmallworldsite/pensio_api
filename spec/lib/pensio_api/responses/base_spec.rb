require 'spec_helper'

describe PensioAPI::Responses::Base do
  let(:test_data) do
    OpenStruct.new({
      body: {
        "Result" => "Success",
        "TransactionId" => 1234,
        "Amount" => 543.21
      },
      headers: {
        "ErrorMessage" => nil,
        "ErrorCode" => "0"
      }
    })
  end

  let(:response_object) { PensioAPI::Responses::Base.new(test_data) }
  let(:transaction) { PensioAPI::Transaction.new(test_data) }

  describe '.raw' do
    it 'provides a reader for the response object' do
      expect(response_object.raw).to eq(test_data.body)
    end
  end

  describe 'method calls' do
    it 'makes the individual response attributes available' do
      expect(response_object.amount).to eq(test_data.body['Amount'])
    end

    context 'with a snake_case method name' do
      it 'converts to CamelCase' do
        expect(response_object.transaction_id).to eq(1234)
      end
    end
  end

  describe '.success?' do
    context 'with a successful response' do
      context 'with success specified in the response body' do
        it 'returns true' do
          expect(response_object.success?).to be true
        end
      end

      context 'with success unspecified in the response body' do
        let(:test_data) do
          OpenStruct.new({
            body: {
              "TransactionId" => 1234,
              "Amount" => 543.21
            },
            headers: {
              "ErrorMessage" => nil,
              "ErrorCode" => "0"
            }
          })
        end
        let(:response_object) { PensioAPI::Responses::Base.new(test_data) }

        it 'returns true' do
          expect(response_object.success?).to be true
        end
      end
    end
  end
end
