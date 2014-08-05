# CapistranoRailsArtifact

A gem to allow you to package your Rails app into a .tar.gz and deploy it easily. This works by creating a
new type of 'scm' for Capistrano

## Installation

Add this line to your application's Gemfile:

    gem 'capistrano-rails-artifact'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano-rails-artifact

## Usage

This gem assumes that you have a tar.gz file in an accessible place. This .tar.gz should contain all the gems
vendored into vendor/bundle as well as the compiled assets.

In your `config/deploy.rb`, you just need to set two variables

```ruby
set :build_artifact_location, '<URL TO TAR GZ>'

set :scm, :rails_artifact
```

## Contributing

1. Fork the repository on Stash
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Stash

