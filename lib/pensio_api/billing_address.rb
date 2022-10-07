# frozen_string_literal: true

module PensioAPI
  class BillingAddress
    attr_reader :first_name, :last_name, :street_address, :city, :region, :postal_code, :country

    def initialize(address_params)
      @first_name = address_params['Firstname']
      @last_name = address_params['Lastname']
      @street_address = address_params['Address']
      @city = address_params['City']
      @region = address_params['Region']
      @postal_code = address_params['PostalCode']
      @country = address_params['Country']
    end
  end
end
