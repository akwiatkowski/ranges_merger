module RangesMergerUtils
  # Convert Array of Arrays or Ranges to Array of Arrays
  def normalize_array(_array)
    klass = _array.first.class
    if klass.to_s == "Array"
      return self.merge_loop(_array)
    elsif klass.to_s == "Range"
      return _array.collect { |a| [a.first, a.last] }
    else
      return []
    end
  end

  # Convert Array of Arrays to Array of Ranges
  def array_to_ranges(_array)
    _array.collect { |r| Range.new(r[0], r[1]) }
  end
end
