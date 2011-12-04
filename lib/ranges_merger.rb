class RangesMerger
  # Merge loop
  def self.merge(_array)
    return _array if _array.size <= 1
    sorted = _array.sort { |a, b| a[0] <=> b[0] }.uniq

    puts sorted.inspect

    result_array = Array.new

    last_result = sorted[0]
    (1...sorted.size).each do |i|
      result = self.two_way_merge([last_result, sorted[i]])
      last_result = result[0]
      result_array += result
    end

    if self.check_overlaps(result_array)
      return self.merge(result_array)
    end

    return result_array
  end

  # Check if there are overlaps in Array
  def self.check_overlaps(_array)
    sorted = _array.sort { |a, b| a[0] <=> b[0] }.uniq

    (1...sorted.size).each do |i|
      return true if sorted[i][0] <= sorted[i-1][0]
      return true if sorted[i][0] <= sorted[i-1][1]
    end
    return false
  end

  def self.two_way_merge(_array)
    a_from = _array[0][0]
    b_from = _array[1][0]
    a_to = _array[0][1]
    b_to = _array[1][1]

    # 1A. outside each other A > B
    if (a_to < b_to and a_from < b_from and a_to < b_from)
      return [[a_from, a_to], [b_from, b_to]]
    end

    # 1B. outside each other B > A
    if  (a_to > b_to and a_from > b_from and b_to < a_from)
      return [[b_from, b_to], [a_from, a_to]]
    end

    # 2A. A is inside B
    if a_from >= b_from and a_to <= b_to
      return [[b_from, b_to]]
    end

    # 2B. B is inside A
    if b_from >= a_from and b_to <= a_to
      return [[a_from, a_to]]
    end

    # 3A. overlapping, A < B
    if a_from < b_from and a_to < b_to and a_to >= b_from
      return [[a_from, b_to]]
    end

    # 3B. overlapping, B < A
    if b_from < a_from and b_to < a_to and b_to >= a_from
      return [[b_from, a_to]]
    end

    raise 'Not implemented'
  end
end