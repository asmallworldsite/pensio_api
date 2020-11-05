require 'spec_helper'

describe PensioAPI::Responses::FundingList do
  let(:funding_list) { PensioAPI::FundingList.all }

  before :each do
    stub_pensio_response('/merchant/API/fundingList', 'funding_list')
  end

  describe 'reader attributes' do
    describe '.funding_lists' do
      it 'is an array of PensioAPI::FundingList objects' do
        expect(funding_list.funding_lists.map(&:class).uniq).to eq([PensioAPI::FundingList])
      end
    end

    describe '.page_count' do
      it 'returns a number of pages' do
        expect(funding_list.page_count).to be_an_instance_of(Integer)
      end
    end
  end
end
