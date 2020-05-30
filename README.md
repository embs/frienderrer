# API Docs & Design

## Referrals

### POST /referrals

Create an user's referral.  It'll return the referral id, which is supposed to
be used for assembling and providing the user with the URL they must share with
their friends.

#### When parameters are missing

We return 422 with a message informing what's the expected request body.

#### When there isn't an user with the given user id

We return 404 and a proper error message instead of unprocessable entity so
whoever is using this endpoint can have a clearer idea of what's going on.

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
