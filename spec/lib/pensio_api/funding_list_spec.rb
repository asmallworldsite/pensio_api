require 'spec_helper'

describe PensioAPI::FundingList do
  let(:response) { PensioAPI::FundingList.all }
  let(:funding_list) { PensioAPI::FundingList.all.first }

  before :each do
    stub_pensio_response('/merchant/API/fundingList', 'funding_list', method: :get)
  end

  describe '.all' do
    it 'returns an instance of PensioAPI::Responses::FundingList' do
      expect(response).to be_an_instance_of(PensioAPI::Responses::FundingList)
    end
  end

  describe 'reader_attributes' do
    specify { expect(funding_list).to respond_to(:filename) }
    specify { expect(funding_list).to respond_to(:amount) }
    specify { expect(funding_list).to respond_to(:acquirer) }
    specify { expect(funding_list).to respond_to(:funding_date) }
    specify { expect(funding_list).to respond_to(:created_at) }
    specify { expect(funding_list).to respond_to(:download_link) }

    specify { expect(funding_list.funding_date).to be_an_instance_of(Date) }
    specify { expect(funding_list.created_at).to be_an_instance_of(Date) }
  end

  describe '.download' do
    before :each do
      stub_pensio_response("http://test_user:password@localhost/merchant.php/API/fundingDownload?id=1", 'funding_download', mime_type: 'text/csv', file_ext: 'csv', base_url: '')
    end

    it 'returns an array of parsed CSV' do
      expect(funding_list.download.map(&:class).uniq).to eq([CSV::Row])
    end
  end
end
