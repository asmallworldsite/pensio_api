
#Required if pensio_api library not in $LOAD_PATH
$:.unshift File.dirname(__FILE__)+ '/../lib/'

require 'httparty'
require 'pensio_api'

PensioAPI::Credentials.base_uri = 'https://testgateway.altapaysecure.com'
PensioAPI::Credentials.username = 'test_user'
PensioAPI::Credentials.password = 'password'

options = {
  'terminal' => 'EmbraceIT Integration Test Terminal',
  'shop_orderid' => 'Ruby_Ex_Setup_AUI_Order_X',
  'amount' => 7.77,
  'currency' => "DKK",
  'cardnum' => "4111111111111111",
  "eyear" => "2025",
  "emonth" => "08",
  "cvc" => 123,
  'agreement' => {
    'type' => 'unscheduled',
    'unscheduled_type' => 'incremental'
  }
}

puts PensioAPI::Ecommerce.create_payment_request(options).url