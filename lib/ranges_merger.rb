class RangesMerger

  # Merge for various objects (Array, Range)
  def self.merge(_array)
    klass = _array.first.class

    if klass.to_s == "Array"
      return self.merge_loop(_array)
    elsif klass.to_s == "Range"
      result = self.merge_loop( _array.collect{|a| [a.first, a.last]} )
      return result.collect{|r| Range.new(r[0], r[1])}
    else
      return []
    end

  end

  # Merge loop
  def self.merge_loop(_array)
    before = _array
    while true do
      after = self.merge_array(_array)
      return after if before == after or not check_overlaps(after)
      before = after
    end
  end

  def self.merge_array(_array)
    return _array if _array.size <= 1
    sorted = _array.sort { |a, b| a[0] <=> b[0] }.uniq

    i = 1
    while i < sorted.size do
      to_merge = [sorted[i-1], sorted[i]]
      # puts "merging #{to_merge.inspect}"

      result = self.two_way_merge(to_merge)
      # puts "merged #{result.inspect}"

      sorted[i-1] = result[0]

      if result.size == 1
        sorted[i] = nil
        sorted.delete_if { |s| s.nil? }
      else
        i += 1
      end
    end

    return sorted
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