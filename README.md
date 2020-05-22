[![Build Status](https://travis-ci.com/inner-whisper/nmax.svg?branch=master)](https://travis-ci.com/inner-whisper/nmax)

# Nmax

Nmax is a text input analyzer. It filters, sorts, and outputs integers from STDIN.

## Installation

Clone this gem to your machine.

Then `cd` into cloned folder, build gem and install locally:

```sh
cd /path/to/gem

gem build nmax.gemspec

gem install --local nmax-0.1.0.gem
```

## Usage

Script accepts data via standard input and use one argument to limit count of numbers in output (`10000` in example below).

    $ cat sample_data_40GB.txt | nmax 10000

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bundle exec rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/inner-whisper/nmax. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/inner-whisper/nmax/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Nmax project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/inner-whisper/nmax/blob/master/CODE_OF_CONDUCT.md).
