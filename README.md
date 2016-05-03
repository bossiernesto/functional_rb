#Functional Ruby

[![Build Status](https://travis-ci.org/bossiernesto/functional_rb.svg?branch=master)](https://travis-ci.org/bossiernesto/functional_rb)
[![Test Coverage](https://codeclimate.com/github/bossiernesto/functional_rb/badges/coverage.svg)](https://codeclimate.com/github/bossiernesto/functional_rb/coverage)

Another repo for showing some functional properties for the Ruby language

##Features 

Taken from [Functors, Applicatives, And Monads In Pictures](http://adit.io/posts/2013-04-17-functors,_applicatives,_and_monads_in_pictures.html) from Haskell

### Maybe

Understands functor map function

~~~ruby
just = Maybe 2
~~~

~~~ruby
Just(42).map { |x| x * x } 
Just(1764)
~~~

~~~ruby
Nothing.map {|x| x * x}
Nothing
~~~

Also bind

~~~ruby
maybe_m >>= proc {|i| i + 4}
5
~~~

And applicatives

~~~ruby
Just do |x, y|
      x ** y
    end.apply(pure(421)).apply(pure(2))
Just(177241)
~~~

~~~ruby
proc {|x,y| x*y} % Just(5) * Just(3) 
Just(15)
~~~

Even lifting

~~~ruby
pure(5).lift_a2 proc {|x,y| x*y}, pure(3)
Just(15)
~~~
