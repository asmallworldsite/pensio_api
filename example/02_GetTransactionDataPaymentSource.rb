#Required if pensio_api library not in $LOAD_PATH
$:.unshift File.dirname(__FILE__)+ '/../lib/'

require 'httparty'
require 'pensio_api'

PensioAPI::Credentials.base_uri = 'https://testgateway.pensio.com'
PensioAPI::Credentials.username = 'username'
PensioAPI::Credentials.password = 'password'

options = {
    'transaction_id' => '12345'
}
transactions = PensioAPI::Transaction.find(options)
newTransaction = PensioAPI::Transaction.new(transactions.raw["Transactions"]["Transaction"])

puts newTransaction.payment_source

#debugging...
#raise newTransaction.status.inspect