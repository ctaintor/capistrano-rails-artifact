# CapistranoRailsArtifact

A gem to allow you to package your Rails app into a .tar.gz and deploy it easily. This works by creating a
new type of 'scm' for Capistrano 3.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'capistrano-rails-artifact'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano-rails-artifact

## Usage

This gem assumes that you have a tar.gz file in an accessible place. This .tar.gz should contain all the gems
vendored into vendor/bundle as well as the compiled assets. An example command to build this archive is:

```sh
export RAILS_ENV=production
rm -rf vendor/bundle
bundle install --without development test --deployment
bundle exec rake assets:precompile
echo `git rev-parse HEAD` > REVISION
mkdir -p dist
tar -cvzf dist/setapp-release.tar.gz --exclude .git --exclude log --exclude "./vendor/bundle/ruby/2.1.0/cache" --exclude "./vendor/bundle/ruby/2.1.0/doc" --exclude .envrc --exclude dist --exclude tmp --exclude coverage --exclude features --exclude spec --exclude vagrants --exclude Vagrantfile --exclude README.md .
```

In your `config/deploy.rb`, you just need to set two variables

```ruby
set :rails_artifact_archive_location, '<URL TO TAR GZ>'

set :scm, :rails_artifact
```

## Testing

Testing is done by spinning up a vagrant box, deploying to it, and then checking the result. You must
have Virtualbox and Vagrant installed, then run:

```sh
bundle exec rake
```

## Contributing

1. Fork it ( https://github.com/ctaintor/capistrano-rails-artifact/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

