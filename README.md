[![Build Status](http://img.shields.io/travis/ONSdigital/ons-data-api.svg)](https://travis-ci.org/ONSdigital/ons-data-api)
[![Dependency Status](http://img.shields.io/gemnasium/ONSdigital/ons-data-api.svg)](https://gemnasium.com/ONSdigital/ons-data-api)
[![Code Climate](http://img.shields.io/codeclimate/github/ONSdigital/ons-data-api.svg)](https://codeclimate.com/github/ONSdigital/ons-data-api)
[![License](http://img.shields.io/:license-mit-blue.svg)](http://ONSdigital.mit-license.org)
[![Badges](http://img.shields.io/:badges-5/5-ff6799.svg)](https://github.com/pikesley/badger)

For background and context on this project see [https://github.com/ONSdigital/prototype-frontend](https://github.com/ONSdigital/prototype-frontend).

THIS IS PURELY A PROTOTYPE. THIS IS NOT A SOURCE OF TRUTH OR OFFICIAL ONS DATA.

Open Statistics Prototype API
=============================

This is a prototype API used in the implementation of the [Open Statistics prototype](https://github.com/ONSdigital/prototype-frontend). It is not a finished application and only implements enough functionality to support the prototype application.

The code is dependent on some [shared data models](https://github.com/ONSdigital/ons_data_models) that are used to access a MongoDB database which contains the statistical data being queried.

The key functionality exposed by the API is:

* Expose a JSON representation of the key model objects, e.g. Series, Releases, Datasets, and Observations
* Expose a simple API for querying over the set of Observations associated with a Dataset, e.g. to filter observations to those that match a specific set of dimension values.

Broadly, each of the model objects is exposed as a resource that can be directly accessed through the API, returning a JSON description of the resource.

Example URIs include:

* Series: `/series/producer-price-index.json`
* Releases in a series: `/series/producer-price-index/releases.json`
* An individual Release: `/series/producer-price-index/releases/2014-02-18.json`
* Datasets in a Release: `/series/producer-price-index/releases/2014-02-18/datasets.json`
* An individual Dataset: `/series/producer-price-index/releases/2014-02-18/datasets/ppi-csdb-ds.json`
* An Observation in a Dataset: `/series/producer-price-index/releases/2014-02-18/datasets/ppi-csdb-ds/observations/mca5-2013may.json`
* Query over Observations in a Dataset to generate a slice: `/series/producer-price-index/releases/2014-02-18/datasets/ppi-csdb-ds/observations.json?product=MCA5&date=2013APR`

The JSON responses use a custom format. The are some standard keys that are present for all objects (e.g. `slug`, `url`). Related objects are described by nested JSON objects, these references don't include the full description of the resource, typically just a url and a title to allow links to be built on web pages and for the API to be traversed.

The frontend application typically makes several API requests to build each page, e.g. to fetch metadata for an Observation, its Dataset, etc.

The API support for querying is implemented in the `[Dataset.slice](https://github.com/ONSdigital/ons_data_models/blob/master/app/models/dataset.rb#L104)` method in the , in the Dataset object. The API query is turned into a Mongo query based on the search parameters with some expansion.

For more background on the design of the API, read [the original design document](http://open-statistics.herokuapp.com/about/technical-architecture) the API designed there is not completely implemented, but the core elements are in place.

## Deploying the API

### Installing the API

First install the basic dependencies:

* Ruby 2.1
* Ruby gems
* [Bundler](http://bundler.io/)
* [MongoDB](https://www.mongodb.org/) for local development and testing

This provides a basic environment. To install the ruby libraries used in the application run:

```
bundle install
```

This will install all of the necessary dependencies which are listed in the `Gemfile`. A key dependency is the `ons_data_models` project which contains the code necessary to interact with the database.

### Running the API Locally

The API expects to talk to a MongoDB database in order to fetch the required data. Mongo is accessed via the [Mongoid](http://mongoid.org/en/mongoid/index.html) library.

The Mongo connection details can be found in `mongoid.yml`. By default the development version will run against a local database called `ons_poc_data_development`. This is the database which the [data conversion scripts](https://github.com/ONSdigital/ons-poc-data) populate, so run those first if you need some initial data.

To use a different database, then edit `mongoid.yml` to alter the connection details.

If Mongo is running, then to run the application locally, just run:

```
bundle exec rackup
```

This should start the application running against the local development database. 

To use a different environment then change the value of the `RACK_ENV` environment variable. 

### Running the API on Heroku

See the Mongo documentation on deploying Rack applications. All of the essential configuration is included in the project.

The deployed demo application uses a Mongo instance hosted in MongoHQ. An environment variable is used to configure the URL for the database `MONGOHQ_URL`. This will need to be configured.

The `RACK_ENV` environment variable should be set to be `production`.

