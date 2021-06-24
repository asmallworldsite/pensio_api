require 'spec_helper'

describe PensioAPI::Responses::Terminal do
  before :each do
    stub_pensio_response('/merchant/API/getTerminals', 'get_terminals')
  end

  let(:response) { PensioAPI::Terminal.all }

  describe 'object mapping' do
    it 'maps terminals to terminal objects' do
      expect(response.terminals.all? { |r| r.class == PensioAPI::Terminal }).to be true
    end

    specify { expect(response.terminals.length).to eq(2) }

    describe '.map_terminals' do
      context 'with one terminal' do
        before :each do
          stub_pensio_response('/merchant/API/getTerminals', 'get_terminals_single')
        end

        let(:response) { PensioAPI::Terminal.all }

        specify { expect(response.terminals.length).to eq(1) }
        specify { expect(response.terminals.map(&:class)).to eq([PensioAPI::Terminal]) }

        it 'returns the terminal inside an array' do
          expect(response.terminals).to be_an_instance_of(Array)
        end
      end

      context 'with more than one terminal' do
        specify { expect(response.terminals.length).to eq(2) }
        specify { expect(response.terminals.map(&:class).uniq).to eq([PensioAPI::Terminal]) }

        it 'returns an array' do
          expect(response.terminals).to be_an_instance_of(Array)
        end
      end
    end
  end

  context 'with no terminals' do
    before :each do
      stub_pensio_response('/merchant/API/getTerminals', 'get_terminals_none')
    end

    describe '.transactions' do
      it 'returns an empty array' do
        expect(response.terminals).to eq([])
      end
    end
  end
end
