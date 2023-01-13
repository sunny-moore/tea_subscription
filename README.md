# README 
## Cloning and Running

1. Clone the repository
1. Run `bundle install`
1. Run `rails db:{create,migrate,seed}`
1. run `rails s` to be able to call the endpoints

## Versioning
- Ruby 2.7.2
- Rails 6.1.7



## Database Structure
![DB Structure](images/db_structure.png)

For simplicity under time constraints, this database uses one-to-many relationships between tables.

## Endpoints

There are 3 endpoints available in this API. The database is also seeded with 3 customers, and 3 teas.

### GET /api/v1/subscriptions
The endpoint requires a request body with the following:

```json
{
  "customer_id": 1
}
```

### POST /api/v1/subscriptions
This endpoint is used for creating a new subscription for a customer. The frequency of a subscription can be `weekly`, `biweekly`, or `monthly`, and the total_price for the subscription will be calculated based on the frequency and tea price. The endpoint requires a request body of the following:

```json
{
  "customer_id": 1,
  "tea_id": 1,
  "frequency": "weekly"
}
```

### PATCH /api/v1/subscriptions 
This endpoint is will 'cancel' an active subscription or return an error if the subscription is not found or already cancelled. It requires the following in the request body

```json
{
  "subscription_id": "1",
}
```
## Testing
This app uses rspec for testing.  To run the testing suite run:
```sh
bundle exec rspec
```

## Further Considerations 

Due to time constraints, I kept this app as simple as possible. With more time, I would have considered a design more suited to business logic, and more scalable.  Other changes I would make:

* Full CRUD functionality for subscriptions
* Full CRUD functionality for customers
* Full CRUD functionality for teas or possibly importing teas from an external API
* More sad path testing