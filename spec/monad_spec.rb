require 'rspec'
require_relative '../src/monad'

describe 'test monads' do
  it 'should raise error' do
    monad = Monad.new(2)
    expect {monad <= lambda{|i| + 2}}.to raise_error NotImplementedError
  end

  it 'identity monad simple test' do
    identity_m = IdentityMonad.new(30)
    foo = identity_m >> lambda {|i| i/2} >> lambda{|i| i*6}
    expect(foo.value).to eq 90
  end

  it 'test maybe simple test' do
    maybe_m = Maybe.new 1
    expect(maybe_m <= lambda {|i| i +4}).to eq(5)
  end

end