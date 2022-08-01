module PensioAPI
  module CardWallet
    def self.session(terminal, validation_url, domain)
      params = {
        terminal: terminal,
        validationUrl: validation_url,
        domain: domain
      }
      request = Request.new('/merchant/API/cardWallet/session', params)
      Responses::CardWalletSession.new(request)
    end

    def self.authorize(provider_data, terminal, shop_orderid, amount, currency, options={})
      params = {
        provider_data: provider_data,
        terminal: terminal,
        shop_orderid: shop_orderid,
        amount: amount,
        currency: currency
      }
      params.merge(options)
      request = Request.new('/merchant/API/cardWallet/authorize', params)
      Responses::CardWalletAuthorize.new(request)
    end
  end
end
