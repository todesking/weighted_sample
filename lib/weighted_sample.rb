module Enumerable
  def weighted_sample_by &block
    return nil if self.empty?

    weights = self.map(&block)
    raise ArgumentError, 'weight should Integer' unless weights.all? &Integer.method(:===)
    raise ArgumentError, 'weight should positive' unless weights.all?{|x|x > 0}

    total_weight = weights.reduce(:+)
    r = rand(total_weight)

    cumlative_weight = 0
    self.zip(weights).each do|obj, weight|
      cumlative_weight += weight
      return obj if r < cumlative_weight
    end
    raise 'Should not reach here'
  end
end
