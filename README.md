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

There are 3 endpoints available in this API:

### POST /api/v1/customers
The `POST /api/v1/customer` endpoint is used for creating a customer within the database which is required for the functionality of the rest of the app. The endpoint requires a request body who's structure is that of the following:

```json
{
  "first_name": "Hubert",
  "last_name": "Roberts",
  "email": "hubertroberts@test.com",
  "address": "399 S. Layoni"
}
```

The API will tell you if a necessary field is missing, or if the email provided has already been taken - otherwise, you will receive a successful response with a serialized set of a data regarding the new user.

### POST /api/v1/subscriptions
The `POST /api/v1/subscriptions` endpoint is used for creating a new subscription for a given user - currently, the API is limited to a single tea which is through it's `title` attribute within the database (only 3 types of tea exist by default when setting up the application, being `"Matcha"`, `"Yerba Mate"`, and `"Green Tea"`). The frequency of a subscription is represented with `0`, `1`, `2`, which translate to `weekly`, `biweekly`, and `monthly` due to an enum within the `subscription` model. The endpoint requires a request body who's structure is that of the following:

```json
{
  "email": "hubertroberts@gmail.com",
  "tea": "Matcha",
  "frequency": 0
}
```


### PATCH /api/v1/subscriptions 
The `PATCH /api/v1/subscriptions` endpoint is currently limited purely to activating or deactivating a given subscription. Possible functionality would include adding/removing teas, and changing frequency. Status' are represented in binary, with `0` representing `active`, and `1` representing `inactive`, respectively. The endpoint requires a request body who's structure is that of the following:

```json
{
  "subscription_id": "1",
  "status": 0
}
```

### GET /api/v1/subscriptions
The `GET /api/v1/subscriptions` endpoint is the most simple of the endpoints. It just requires an email that exists within the database, which will then give you a serialized set of all the users subscriptions. The endpoint requires a request body who's structure is that of the following:

```json
{
  "email": "hubertroberts@gmail.com"
}
```

### DELETE /api/v1/subscriptions
The 'DELETE /api/v1/subscriptions' endpoint is used to delete a specific subscription of a given account. There are most-definitely significantly more secure ways I could've approached this endpoint (much more, the entire creation of this application), but it was outside of the scope required for technical project completion. The endpoint requires a request body who's structure is that of the following:

```json
{
  "email": "hubertroberts@gmail.com",
  "subscription_id": "1"
}
```
The email is required to send the user a serialized JSON of all their now currently existing subscriptions.

## Misc 

Because this was a short take-home project for the program I'm attending, there's a lot of functionality that doesn't exist that seemingly should, or things that don't seem as rounded out in structure because there wasn't enough time to implement it. Several things that I would do if given more time to improve this application and make it more rounded it out would be:

* Automatically creating an API key attached to each customer and creating those checks (e.g., a required field within the body of a request) to restrict who can make requests to the application 
* Restrict user CRUD functionality solely to their own subscriptions 
* Make subscription cost based off of the types of tea, quantity, and frequency, instead of having it statically set
* Create tea 'bundles' to more effectively show why the database was structured the way it was 
* Find teas based off of more unique, salted names, or purely by ID instead of by plain names in both request bodies and the controller