require 'bundler/setup'
require 'webmock/rspec'
require 'httparty'
require 'active_support'
require 'pensio_api'
require './spec/support/helpers'

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.include Helpers

  config.before :each do
    PensioAPI::Credentials.base_uri = 'https://testgateway.pensio.com'
    PensioAPI::Credentials.username = 'test_user'
    PensioAPI::Credentials.password = 'password'
    PensioAPI::Credentials.allow_defaults = true # because some spec examples set up additional creds
  end

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
end
