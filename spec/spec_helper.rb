require 'bundler/setup'
require 'webmock/rspec'
require 'httparty'
require 'active_support'
require 'pensio_api'
require './spec/support/helpers'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.include Helpers

  config.before :each do
    PensioAPI::Credentials.base_uri = 'https://testgateway.pensio.com'
    PensioAPI::Credentials.username = 'test_user'
    PensioAPI::Credentials.password = 'password'
  end

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
end
