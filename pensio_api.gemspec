lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pensio_api/version'

Gem::Specification.new do |s|
  s.name = 'pensio_api'
  s.version = PensioAPI::VERSION
  s.license = 'BSD-3-Clause'
  s.summary = "Provides integration for the Pensio Merchant API"
  s.authors = ['Michael Sell', 'Rory Sinclair']
  s.email = 'michael@asw.com'
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.require_paths = ["lib"]
  
  s.add_development_dependency 'rspec', '>= 2.14'
  s.add_development_dependency 'webmock', '~> 1.16.1'
  s.add_development_dependency 'guard', '~> 2.2.5'
  s.add_development_dependency 'guard-rspec', '~> 4.2.4'

  s.add_dependency 'httparty', '>= 0.12.0'
  s.add_dependency 'activesupport', '>= 3.2'
  s.add_dependency 'multi_xml', '>= 0.5.2'
end
