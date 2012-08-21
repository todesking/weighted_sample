# weighted_sample

This gem add Enumerable#weighted_sample_by mehtod.

## Installation

Add this line to your application's Gemfile:

    gem 'weighted_sample'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install weighted_sample

## Usage

[1, 9].weighted_sample_by {|x| x}
=> 9(90%) or 1(10%)

### Restrictions

* Weight is zero or positive Integer(Negative or Float is not allowed).
* Sum of weights should > 0

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
