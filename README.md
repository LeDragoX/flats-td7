# Flats (TreinaDev 7)

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

## Project Started

```sh
# Don't run this command
╰─❯ rails new flats-td7 -T --skip-action-mailbox --skip-active-storage --skip-action-cable
```

## Ruby version

- Ruby v3.0.2 | Rails >= 6.1.4.1

## System dependencies

- Make sure [_Yarn_](https://classic.yarnpkg.com/lang/en/docs/install/#windows-stable) is installed;
- All Rails stuff;
- rspec-rails - Unit & Web UI tests;
- capybara - Web UI tests;
- devise - Login & Auth manager;
- bootstrap - Automated CSS;
- simplecov - Test coverage;
- factory_bot_rails - Fast Seed/Models creation on db for Testing and Devlopment mode;
- ffaker - Randomize every instance variable;
- rubocop/rubocop-rails - Hands up! Your code is bad. Ensure you are following your team style guide;

## Configuration

```sh
bundle install
```

## Database creation

> No need.

## Database initialization

```sh
rails db:migrate
rails db:seed
```

## How to run the test suite

```sh
rspec
```

## Services (job queues, cache servers, search engines, etc.)

> ...

## Deployment instructions

```sh
rails server
```

## Commands Cheatsheet

<details>
    <summary>Click to expand</summary>

```sh
### Rails ###
# Show listening routes #
rails routes

### Database management ###
# Create model #
# Those without ':' are strings
rails generate model property title description rooms:integer

# Add columns #
rails generate migration add_fields_to_properties parking_slot:boolean bathrooms:integer pets:boolean daily_rate:integer

# Add foreign key #
rails g migration add_property_type_ref_to_property property_type:references

### Devise ###
# Generate a model #
rails generate devise user

# Expose the devise views per model # Look: https://github.com/heartcombo/devise/wiki/How-to-Setup-Multiple-Devise-User-Models#3-if-you-want-scoped-views
rails g devise:views users
```

</details>
