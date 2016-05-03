require 'rspec'
require_relative '../src/maybe'

include Functional::Maybe

describe 'test monads' do
  it 'should create Just' do
    just = Maybe 2
    expect(just.class).to eq(Just)
    expect(just.value).to eq(2)
  end

  it 'should create Nothing' do
    just = Maybe nil
    expect(just).to eq(Nothing)
  end

  it 'should map' do
    just_result = Just(42).map { |x| x * x }
    expect(just_result.value).to eq(1764)

    just_result_2 = Just(42).% {|x| x * 2}
    expect(just_result_2.value).to eq(84)

    expect((proc {|x| x * 2} % Just(3))).to eq(Just(6))
  end

  it 'should not map' do
    expect(Nothing.map {|x| x * x}).to eq Nothing
  end

  it 'should bind' do
    maybe_m = Maybe(1)
    expect(maybe_m >>= proc {|i| i + 4}).to eq(5)
  end

  it 'compare Just and Nothing values' do
    just_1 = Maybe 23
    just_2 = Just 23
    just_3 = Just 12

    expect(just_1 == just_2).to be_truthy
    expect(just_1 == just_3).to eq(false)
    expect(just_1 == Nothing).to eq(false)
    expect(just_2 == Nothing).to eq(false)
  end

  it 'applicate just' do

    just = Just do |x|
      x + 1
    end

    expect(just.apply(pure(32))).to eq(Just(33))

    expect(Just(proc {|x| x * 2}) * pure(32)).to eq(Just(64))
  end

  it 'applicative with multiple parameters' do
    expect(Just do |x, y|
      x ** y
    end.apply(pure(421)).apply(pure(2))).to eq(Just(177241))
  end

  it 'applicative/functor test' do
    expect(proc {|x,y| x*y} % Just(5) * Just(3)).to eq(Just(15))
  end

  it 'understands lifting' do
     expect(pure(5).lift_a2 proc {|x,y| x*y}, pure(3)).to eq(Just(15))
  end
end