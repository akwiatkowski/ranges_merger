module RangesMergerExclusion

  def exclude(_array_a, _array_b)
    new_array = Array.new

    # array of bases
    bases = merge(_array_a)

    # loop for "base"
    i = 0
    while i < bases.size
      base = bases[i]

      # loop for "exclusions"
      _array_b.each do |b|
        # base can be excluded to this level that is empty
        if not base.nil?
          result = two_way_exclusion([base, b])
          if result.size == 1
            base = two_way_exclusion([base, b])[0]
          elsif result.size == 2
            # first go to processing, last go to base pool
            base = result[0]
            bases << result[1]
          elsif result.size == 0
            base = nil
          end
        end

      end

      new_array << base if not base.nil?
      i += 1
    end

    return merge(new_array)
  end

  # Merge two Arrays
  def two_way_exclusion(_array)
    base_from = _array[0][0]
    base_to = _array[0][1]

    excl_from = _array[1][0]
    excl_to = _array[1][1]

    # puts "base_from #{base_from} base_to #{base_to} excl_from #{excl_from} excl_to #{excl_to}"

    # 1A. BASE < EXCL
    if (base_to < excl_to and base_from < excl_from and base_to < excl_from)
      # puts "1a"
      return [[base_from, base_to]]
    end

    # 1B. BASE > EXCL
    if  (base_to > excl_to and base_from > excl_from and excl_to < base_from)
      # puts "1b"
      return [[base_from, base_to]]
    end

    # 2 EXCL contains BASE => nothing
    if base_from >= excl_from and base_to <= excl_to
      # puts "2"
      return []
    end

    # 3 EXCL inside BASE
    if excl_from > base_from and excl_to < base_to
      # puts "3"
      return [[base_from, excl_from], [excl_to, base_to]]
    end

    # 4A EXCL has inside BASE from
    if excl_from <= base_from and excl_to >= base_from
      # puts "4a"
      return [[excl_to, base_to]]
    end

    # 4b EXCL has inside BASE to
    if excl_from <= base_to and excl_to >= base_from
      # puts "4b"
      return [[base_from, excl_from]]
    end

    raise 'Not implemented, is it even possible?'
  end

end
