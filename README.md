# Datamappify [![Build Status](https://secure.travis-ci.org/fredwu/datamappify.png?branch=master)](http://travis-ci.org/fredwu/datamappify) [![Dependency Status](https://gemnasium.com/fredwu/datamappify.png)](https://gemnasium.com/fredwu/datamappify) [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/fredwu/datamappify)

Separate domain logic from data persistence, based on the [Repository Pattern](http://martinfowler.com/eaaCatalog/repository.html).

__This library is current in Proof-of-Concept stage, do NOT use it for anything other than experimentation.__

## Overview

Datamappify is a thin layer on top of ActiveRecord. The design goal is to utilise ActiveRecord but separate domain logic (behaviour) and data persistence.

Datamappify consists of three components:

- Entity
- Data
- Repository

__Entity__ is your model, it is responsible for mainly storing behaviour. Some structure (i.e. model relationships) is also stored here for convenience.

__Data__ as the name suggests, holds your model data. It is an ActiveRecord object.

__Repository__ is responsible for data retrieval and persistence, e.g. `find`, `save` and `destroy`, etc.

## Installation

Add this line to your application's Gemfile:

    gem 'datamappify'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install datamappify

## Usage

Model:

```ruby
class User
  include Datamappify::Entity

  # ActiveModel::Validations rules are wrapped in the `validations` block
  validations do
    validates :first_name, :presence => true
  end

  # ActiveRelation collections are wrapped in the `relationships` block
  relationships do
    has_one  :role
    has_many :comments
  end
end
```

Corresponding repository:

```ruby
user_repository = Datamappify::Repository.new(User)
```

Retrieving records:

```ruby
user = user_repository.find(1)
```

Saving/updating a record:

```ruby
user_repository.save(user)
```

Destroying a record:

```ruby
user_repository.destroy(user)
```

## Todo

- Entity should dictate Data, so schema and migrations should be automatically generated
- Repository should handle asscociated data

## Similar Projects

- [Curator](https://github.com/braintree/curator)
- [Edr](https://github.com/nulogy/edr)

## Author

[Fred Wu](http://fredwu.me/)

## License

Licensed under [MIT](http://fredwu.mit-license.org/)
