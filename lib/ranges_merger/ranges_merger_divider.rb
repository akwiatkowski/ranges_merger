module RangesMergerDivider
  # Divide not merged array
  def divide(_array, interval, allow_partials = true)
    divided_array = Array.new
    joined_array = merge(_array)

    joined_array.each do |r|
      r_from = r[0]
      r_to = r[1]
      r_now = r_from

      while r_now <= r_to
        new_r_from = r_now
        new_r_to = new_r_from + interval

        if allow_partials and new_r_to > r_to and new_r_from < r_to
          new_r_to = r_to
        end

        divided_array << [new_r_from, new_r_to] if new_r_to <= r_to
        r_now += interval
      end



    end

    return divided_array

  end
end
