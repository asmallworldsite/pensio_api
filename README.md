# PensioAPI
This gem covers most of the Merchant and eCommerce API functionality provided by Pensio (http://www.pensio.com).

## Getting Started

First, register your Pensio credentials. For example, if you're using rails, create `config/initializers/pensio.rb` with the following contents:

```
PensioAPI::Credentials.base_uri = 'Your pensio gateway URI'
PensioAPI::Credentials.username = 'Your pensio username'
PensioAPI::Credentials.password = 'Your pensio password'
```

## Transactions

To query transactions in your Pensio gateway, use the method `PensioAPI::Transaction.find`. This takes a number of parameters as defined in the Pensio documentation. For example:

```
PensioAPI::Transaction.find(transaction_id: '123')
```

This returns an enumerable `PensioAPI::Responses::Transaction` object as many `PensioAPI::Transaction` objects as match your criteria.

With a transaction object, you can perform several actions.

* Determine status via `.status`, `.captured?` and `.reserved`
* Refund via `.refund`
* Expose terminal details via `.terminal`
* Expose billing address via `.billing_address`
* Map to a subscription object via `.to_subscription`
* Map to a reservation object via `.to_reservation`

## Funding Lists

The funding list functionality of the Pensio Merchant API is exposed via `PensioAPI::FundingList.all` which returns an iterable collection of `PensioAPI::FundingList` objects. Calling `.download` on any of these objects downloads and parses the CSV file from the Pensio Gateway.

## Terminals

To query terminals, use the method `PensioAPI::Terminal.all`. This will return an enumerable object containing as many `PensioAPI::Terminals` as are associated with your gateway.

## Reservations

To create a fixed amount reservation (via the API call '/merchant/API/reservationOfFixedAmount') use the class method `PensioAPI::Reservation.of_fixed_amount`.

To capture an existing reservation, use `.capture`. Likewise to release it, use `.release`.

## Subscriptions

To create a subscription, use the class method `PensioAPI::Subscription.setup`. This takes the arguments documented in Pensio's documentation for the '/merchant/API/setupSubscription' API call.

With an existing subscription, use `.reserve_charge` to place a charge reservation upon the subscription or `.charge` to attempt a reservation and charge of the associated transaction.

## eCommerce

PensioAPI::Ecommerce is a module which exposes the eCommerce API endpoints. Two module methods `.create_payment_request` and `.create_multi_payment_request` can be used to generate payment URLs for a multitude of payment types. Consult the Pensio eCommerce API documentation for parameter details.

## Callbacks

`PensioAPI::Callback` provides two methods `.parse_success` and `.parse_failure`. These are designed to parse the callbacks Pensio send to your transaction success and transaction failure endpoints. Each returns a callback response which exposes the transaction details for processing by your app.

## Error Handling

The library provides two generic error classes for requests.

* `PensioAPI::Errors::BadRequest` is raised when the response from Pensio indicates that a request has invalid parameters
* `PensioAPI::Errors::GatewayError` is raised when the parameters have been provided correctly, but the gateway was unable to process the request

Additionally, a third error class `PensioAPI::NoCredentials` is raised if credentials have not been provided. See "Getting Started" for more details.

## TODO

* Better documentation - more examples, RDoc docs
* Further API implementation

## Contributing

Contributions are very welcome. Please submit pull requests with adequately-tested code.
