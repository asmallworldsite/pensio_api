require 'spec_helper'

describe PensioAPI::Request do
  describe '.new' do
    before :each do
      allow(PensioAPI::Request).to receive(:post).and_return(construct_response(nil))
    end

    it 'POSTs to the given API path and passes in request options' do
      request_options = PensioAPI::Request.new('/test').send(:request_options, {})
      expect(PensioAPI::Request).to receive(:post).with('/test', request_options)
      PensioAPI::Request.new('/test')
    end
  end

  describe '.response_contains' do
    context 'with a populated response body' do
      before :each do
        allow(PensioAPI::Request).to receive(:post).and_return(
          construct_response({
              'Test' => 'true'
            })
        )
      end

      let(:request) { PensioAPI::Request.new('/test') }

      context 'given a valid key' do
        it 'returns true' do
          expect(request.response_contains?('Test')).to be true
        end
      end

      context 'given an invalid key' do
        it 'returns false' do
          expect(request.response_contains?('OtherTest')).to be false
        end
      end
    end

    context 'with an empty response body' do
      before :each do
        allow(PensioAPI::Request).to receive(:post).and_return(construct_response(nil))
      end

      let(:request) { PensioAPI::Request.new('/test') }

      it 'returns false' do
        expect(request.response_contains?('Test')).to be false
      end
    end
  end

  describe '.request_options' do
    before :each do
      allow(PensioAPI::Request).to receive(:post).and_return(construct_response(nil))
    end

    let(:p) { PensioAPI::Request.new('/test') }

    specify { expect(p.send(:request_options, {})[:basic_auth]).to_not be_nil }

    it 'appends basic auth to the options' do
      expect(p.send(:request_options, {})[:basic_auth]).to eq(p.send(:auth))
    end

    specify { expect(p.send(:request_options, {})[:headers]).to_not be_nil }

    it 'appends headers to the options' do
      expect(p.send(:request_options, {})[:headers]).to eq(PensioAPI::Request::HEADERS)
    end

    context 'with additional headers' do
      it 'merges given headers into the defaults' do
        headers = p.send(:request_options, { headers: {'Test' => '1234'} })[:headers]
        expect(headers).to eq({'Test' => '1234'}.merge(PensioAPI::Request::HEADERS))
      end
    end

    context 'with body parameters' do
      it 'assigns these to the body parameter' do
        expect(p.send(:request_options, {transaction_id: 5432})[:body][:transaction_id]).to eq(5432)
      end
    end

    context 'with alternative credentials' do
      it 'sends the correct credentials' do
        creds = PensioAPI::Credentials.for(:ticketing)
        creds.base_uri = 'https://www.test.com'
        creds.username = 'ticketing_username'
        creds.password = 'ticketing_password'

        # pass credentials instance
        req1 = PensioAPI::Request.new('/test', credentials: creds)

        # or pass credentials set name
        req2 = PensioAPI::Request.new('/test', credentials: :ticketing)

        expect(req1.send(:request_options, {})[:basic_auth]).to_not be_nil
        expect(req1.send(:request_options, {})[:basic_auth]).to eq({ username: creds.username, password: creds.password})

        expect(req2.send(:request_options, {})[:basic_auth]).to_not be_nil
        expect(req2.send(:request_options, {})[:basic_auth]).to eq({ username: creds.username, password: creds.password})
      end
    end
  end

  describe 'error handling' do
    context 'with a bad request' do
      before :each do
        stub_pensio_response('/merchant/API/payments', 'bad_request_error')
      end

      it 'raises a PensioAPI::Errors::BadRequest error' do
        expect { PensioAPI::Transaction.find }.to raise_error PensioAPI::Errors::BadRequest
      end
    end

    context 'with a gateway error' do
      before :each do
        stub_pensio_response('/merchant/API/payments', 'pensio_error')
      end

      it 'raises a PensioAPI::Errors::GatewayError' do
        expect { PensioAPI::Transaction.find }.to raise_error PensioAPI::Errors::GatewayError
      end
    end

    context 'with incomplete credentials' do
      before :each do
        PensioAPI::Credentials.base_uri = nil
      end

      it 'raises a PensioAPI::Errors::NoCredentials error' do
        expect { PensioAPI::Transaction.find }.to raise_error PensioAPI::Errors::NoCredentials
      end
    end
  end
end
