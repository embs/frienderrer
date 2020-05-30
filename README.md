# API Docs & Design

## Referrals

### POST /referrals

Create an user's referral.  It'll return the referral id, which is supposed to
be used for assembling and providing the user with the URL they must share with
their friends.

#### Example

Request:

    curl -i -XPOST -H 'Content-Type: application/json' localhost:3000/referrals -d '{
      "user_id": 1
    }'

Response:

    HTTP/1.1 201 Created

    {"referral":{"id":2}}

#### When parameters are missing

We return 422 with a message informing what's the expected request body.

#### When there isn't an user with the given user id

We return 404 and a proper error message instead of unprocessable entity so
whoever is using this endpoint can have a clearer idea of what's going on.

## Users

This is not meant to be an user authentication and / or authorization service but
one for handling only user referrals instead.  We have an users table for the
sake of keeping the users' credits.

The users endpoints allows other architectural components to inform the event of
an user signing up -- with or without an attached referral.

### POST /users

Create a new user.  It'll apply credits policies according to the presence of
the referral id within the request params.

#### Example

Request:

    curl -XPOST -H 'Content-Type: application/json' localhost:3000/users -d '{
      "user": { "name": "Alice" },
      "referral_id": 1
    }'

Response:

    HTTP/1.1 204 No Content

#### When parameters are missing

We return 422 with a message informing what's the expected request body.

# Dev Docs

## Dependencies

- Ruby 2.6.6
- Bundler 2.1.4

## Setup

### Install gems

    $ bundle

### Setup the database

    $ bin/rake db:setup

## Tests

Run with

    $ bin/rspec
