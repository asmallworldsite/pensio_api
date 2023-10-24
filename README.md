# Important
This gem is no longer maintained. AltaPay maintain their own fork [here](https://github.com/AltaPay/sdk-ruby).

# PensioAPI
This gem covers most of the Merchant and eCommerce API functionality provided by AltaPay, formerly Pensio (https://altapay.com).

Ruby 2.7.x or later is required.

## Getting Started

First, register your Pensio credentials. For example, if you're using rails, create `config/initializers/pensio.rb` with the following contents:

```
PensioAPI::Credentials.base_uri = 'Your pensio gateway URI'
PensioAPI::Credentials.username = 'Your pensio username'
PensioAPI::Credentials.password = 'Your pensio password'
```

This is sufficient in the simple case where you only have a single integration with Pensio, using a single set of credentials.

If you require support for multiple connections to Pensio's API, using different sets of credentials, you must define named 'credentials sets' - see below under [Multiple Credentials Sets](#multiple-credentials-sets).

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

To create a reservation (via the API call '/merchant/API/reservation') use the class method `PensioAPI::Reservation.create`.

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

## Multiple Credentials Sets

If you require multiple connections to Pensio's API using different credentials, you must set up named credentials sets.  For example, if you need separate credentials for your membership payments and ticket sales, you can configure them as follows:

```
PensioAPI::Credentials.for(:membership).base_uri = 'Your pensio gateway URI for memberships'
PensioAPI::Credentials.for(:membership).username = 'Your pensio username for memberships'
PensioAPI::Credentials.for(:membership).password = 'Your pensio password for memberships'
```

```
PensioAPI::Credentials.for(:tickets).base_uri = 'Your pensio gateway URI for tickets'
PensioAPI::Credentials.for(:tickets).username = 'Your pensio username for tickets'
PensioAPI::Credentials.for(:tickets).password = 'Your pensio password for tickets'
```

In this case, you *must* also pass the credential set to each request, by including a 'credentials' key in the options hash.  The value should be a String or Symbol with the credential set name (e.g. :tickets, 'tickets'), or the PensioAPI::Credentials instance itself (e.g. PensioAPI::Credentials.for(:tickets)).  For example, these three examples are equivalent:

```
PensioAPI::Transaction.find(credentials: :tickets, transaction_id: '123')
PensioAPI::Transaction.find(credentials: 'tickets', transaction_id: '123')
PensioAPI::Transaction.find(credentials: PensioAPI::Credentials.for(:tickets), transaction_id: '123')
```

Typically if you have multiple credentials sets, the default credentials (i.e. PensioAPI::Credentials.base_uri etc) are ignored, and making any Pensio API requests without explicitly passing a 'credentials' argument will raise  `PensioAPI::NoCredentials`. However, if you have an existing Pensio integration using the simple default credentials approach and now want to also use a named credentials set, you can tell the library to explicitly allow this, by setting:

```
PensioAPI::Credentials.allow_defaults = true
```

In this scenario, requests performed without an explicit credentials set will use the default set, and those with named credentials will use those.  BE CAREFUL: If you accidentally omit the 'credentials' options key when making a request, it will use the default credentials set, which could lead to undesired behaviour.  This is why, by default, if you have multiple credentials sets, the default set is disabled.

## TODO

* Better documentation - more examples, RDoc docs
* Further API implementation

## Contributing

Contributions are very welcome. Please submit pull requests with adequately-tested code.
