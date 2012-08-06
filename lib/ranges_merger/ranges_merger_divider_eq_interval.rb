module RangesMergerDividerEqInterval
  # Divide with equal interval
  def divide_eqi(_array, interval, total_min)
    # calculate for whole range
    joined_array = merge(_array)

    # anti-nuke
    return [] if joined_array.size == 0 or joined_array.nil?

    min = joined_array.first[0]
    min = total_min if total_min < min and not total_min.nil? # before merging
    max = joined_array.last[1]
    divided_array = divide([[min, max]], interval)

    # remove sub-ranges
    filtered_array = Array.new
    joined_array.each do |ja|
      filtered_array += divided_array.select{|da| ja[0] <= da[0] and ja[1] >= da[1] }
    end
    filtered_array = filtered_array.sort.uniq

    return filtered_array
  end
end
