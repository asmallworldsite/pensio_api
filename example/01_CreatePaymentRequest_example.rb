
#Required if pensio_api library not in $LOAD_PATH
$:.unshift File.dirname(__FILE__)+ '/../lib/'

require 'httparty'
require 'pensio_api'

PensioAPI::Credentials.base_uri = 'https://testgateway.pensio.com'
PensioAPI::Credentials.username = 'test_user'
PensioAPI::Credentials.password = 'password'

options = {
    'terminal' => 'AltaPay Test Terminal',
    'shop_orderid' => 'Ruby_Test_Order123',
    'amount' => 12.22,
    'currency' => "EUR"
}

puts PensioAPI::Ecommerce.create_payment_request(options).url
