load File.join(File.dirname(__FILE__), '..', 'lib', 'weighted_sample.rb')

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
    subject.weighted_sample_by(&ID).should be_a(Integer)
    subject.should be_include(subject.weighted_sample_by(&ID))
  end

  it 'returns value with respect for its weight' do
    s = samples(10000) { subject.weighted_sample_by(&ID) }
    s[90].should be_within(5000).of(9000)
    s[9].should be_within(500).of(900)
    s[1].should be_within(50).of(100)
  end

  describe 'the Enumerable is empty' do
    subject { [] }
    it 'returns nil' do
      subject.weighted_sample_by(&ID).should be_nil
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
        subject.weighted_sample_by(&ID).should == 1
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
