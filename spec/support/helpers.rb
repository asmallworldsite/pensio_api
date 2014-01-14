module Helpers
  def file_fixture(filename)
    open(File.join(File.dirname(__FILE__), 'fixtures', "#{filename.to_s}")).read
  end

  def stub_pensio_response(path, fixture)
    stub_request(:post, "#{PensioAPI::Credentials.base_uri}#{path}")
      .to_return(
        body: file_fixture("#{fixture}.xml"),
        status: 200,
        headers: {
          'Content-Type' => 'application/xml'
        }
      )
  end

  def construct_response(hash)
    OpenStruct.new(
      parsed_response: {
        'APIResponse' => {
          'Body' => hash
        }
      }
    )
  end

  def reservation_arguments
    {
      terminal: 'Pensio Test Terminal',
      shop_orderid: 'Test Payment',
      amount: 123.45,
      currency: 'eur'
    }
  end
end
