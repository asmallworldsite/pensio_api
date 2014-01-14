require 'spec_helper'

describe PensioAPI::Terminal do
  before :each do
    stub_pensio_response('/merchant/API/getTerminals', 'get_terminals')
  end

  describe '.all' do
    let(:response) { PensioAPI::Terminal.all }

    specify { expect(response.terminals.length).to eq(2) }

    it 'maps the response to terminal objects' do
      terminal_classes = response.terminals.map(&:class).uniq
      expect(terminal_classes).to eq([PensioAPI::Terminal])
    end
  end
end
