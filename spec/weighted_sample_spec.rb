require_relative 'spec_helper'

def samples(n, &block)
  n.times.each_with_object(Hash.new{|_|0}) {|_,h|
    sampled = block.call
    h[sampled] += 1
  }
end

# IDentity function
ID = ->(x){x}

describe 'Enumerable#weighted_sample_by' do
  subject { [1, 9, 90] }
  it 'returns its content value' do
    expect(subject.weighted_sample_by(&ID)).to be_a(Integer)
    expect(subject).to include(subject.weighted_sample_by(&ID))
  end

  it 'returns value with respect for its weight' do
    s = samples(10000) { subject.weighted_sample_by(&ID) }
    expect(s[90]).to be_within(5000).of(9000)
    expect(s[9]).to be_within(500).of(900)
    expect(s[1]).to be_within(50).of(100)
  end

  describe 'the Enumerable is empty' do
    subject { [] }
    it 'returns nil' do
      expect(subject.weighted_sample_by(&ID)).to be_nil
    end
  end

  describe 'weight is not Integer' do
    subject { [0.1, 2] }
    it 'raises ArgumentError' do
      expect { subject.weighted_sample_by(&ID) }.to raise_error(ArgumentError)
    end
  end

  describe 'weight is negative' do
    NEGATER = ->(x){-x}
    it 'raises ArgumentError' do
      expect { subject.weighted_sample_by(&NEGATER) }.to raise_error(ArgumentError)
    end
  end

  describe 'weight contains zero' do
    subject { [0, 1, 0, 0, 1] }
    it 'returns non-zero weighted element' do
      10.times do
        expect(subject.weighted_sample_by(&ID)).to eq 1
      end
    end
  end

  describe 'weight is all zero' do
    subject { [0, 0] }
    it 'raises ArgumentError' do
      expect { subject.weighted_sample_by(&ID) }.to raise_error(ArgumentError)
    end
  end
end
