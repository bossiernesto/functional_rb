require_relative '../src/util/composer'

describe 'test composer' do
  it 'compose two procs' do
    p1 = proc {|x| x + 1}
    p2 = proc {|x| x * 2}

    expect((Proc.compose p1, p2).call(2)).to eq(5)

    expect((p1 * p2).call(1)).to eq(3)
    expect((p2 * p1).call(1)).to eq(4)
  end

  it 'compose infix composition' do
    p2 = proc {|x| x * 2}

    expect((proc {|x| x + 23} * p2).call(2)).to eq(27)
  end

end
