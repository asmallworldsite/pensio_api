module Helpers
  def file_fixture(filename)
    open(File.join(File.dirname(__FILE__), 'fixtures', "#{filename}")).read
  end

  def stub_pensio_response(path, fixture, options = {})
    file_ext = options[:file_ext] || 'xml'
    mime_type = options[:mime_type] || 'application/xml'
    base_url = options[:base_url] || 'https://test_user:password@testgateway.pensio.com'
    method = options[:method] || :post
    stub_request(method, "#{base_url}#{path}")
      .to_return(
        body: file_fixture("#{fixture}.#{file_ext}"),
        status: 200,
        headers: {
          'Content-Type' => mime_type
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
