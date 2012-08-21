module Enumerable
  def weighted_sample_by &block
    return nil if self.empty?

    weights = self.map(&block)
    raise ArgumentError, 'Weight should Integer' unless weights.all? &Integer.method(:===)

    total_weight = weights.reduce(:+)
    raise ArgumentError, 'Sum of weights should > 0' unless total_weight > 0

    r = rand(total_weight)

    cumlative_weight = 0
    self.zip(weights).each do|obj, weight|
      cumlative_weight += weight
      return obj if r < cumlative_weight
    end
    raise 'Should not reach here'
  end
end
