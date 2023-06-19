require 'spec_helper'

describe PensioAPI::FundingListRequest do
  before :each do
    stub_pensio_response('/merchant/API/fundingList', 'funding_list', method: :get)
    stub_pensio_response("http://test_user:password@localhost/merchant.php/API/fundingDownload?id=1", 'funding_download', mime_type: 'text/csv', file_ext: 'csv', base_url: '')
  end

  let(:request) { PensioAPI::FundingListRequest.new(PensioAPI::FundingList.all.first.download_link) }

  describe 'result' do
    specify { expect(request).to respond_to(:result) }
    it 'returns a parsed CSV array' do
      expect(request.result.map(&:class).uniq).to eq([CSV::Row])
    end
  end
end
