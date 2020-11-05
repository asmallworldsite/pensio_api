require 'spec_helper'

describe PensioAPI::Responses::ChargebackCallback do
  let(:response) { PensioAPI::Callback.parse_chargeback(file_fixture("chargeback_callback.xml")) }

  it "succeeds" do
    expect(response.success?).to be true
  end
end
