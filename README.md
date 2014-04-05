# analog

A Ruby helper for scaling numbers.

#### Background

This helper provides a quick way to take a number and scale it given a source and destination range/set/etc.

It's useful for converting data from raw values to a range used for display or other kinds of output.

I use this all the time in music programming, converting OSC messages to musical notes and things like that and figure it might be useful to others.

A simple example is:

If you want to plot a point on a 500px graph using a data that lies in the 0..1 range, do

```ruby
Scale.transform(0.5).using(0..1, 0..500)
=> 250
```

Please note: I am not a Math Person.  If I've named any concepts here poorly, [please let me know](https://github.com/arirusso/analog/issues).  Or [submit a pull request](https://github.com/arirusso/analog/pulls)

#### Usage

```ruby
require "scale"
```

This example will scale a number down by 1/10th`

```ruby
Scale.transform(22).using(0..150, 0..15)
=> 2

```

You can use Arrays and Sets
```ruby
Scale.transform(8).using(Set.new([0, 2, 4, 8, 16, 64]), 0..10)
=> 6

Scale.transform(0.40).using(0..1, [0, 2, 4, 8, 12, 16, 32, 64, 128, 512])
=> 8
```

See the [examples](https://github.com/arirusso/analog/tree/master/examples) for more

###### Core Extension

There is a Numeric extension that you can optionally include.

```ruby
require "scale/core_ext"

0.40.scaled_from(0..1).to([0, 2, 4, 8, 12, 16, 32, 64, 128, 512])
=> 8
```

See the [core_ext example](https://github.com/arirusso/analog/blob/master/examples/core_ext.rb) for more examples.

#### Installation

    gem install analog
    
or with Bundler

    gem "analog"

#### License

Licensed under Apache 2.0, See the file LICENSE
Copyright (c) 2014 [Ari Russo](http://arirusso.com) 

