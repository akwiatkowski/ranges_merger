class RangesMerger

  def self.energy_calculation(voltages, currents)
    return 0 if voltages.size == 0 or currents.size == 0

    # sort time ranges
    voltages = voltages.sort { |a, b| a[0] <=> b[0] }
    currents = currents.sort { |a, b| a[0] <=> b[0] }
    # without checking of overlaps

    # for loop
    voltage_i = 0
    current_i = 0

    # output
    energy = 0.0

    voltage_first = true
    voltage_first = false if currents[0][0] < voltages[0][0]

    while voltage_i < voltages.size and current_i < currents.size
      v = voltages[voltage_i]
      c = currents[current_i]

      # common time range
      _time_from = v[0]
      _time_from = c[0] if c[0] > v[0]

      _time_to = v[1]
      _time_to = c[1] if c[1] < v[1]

      # adding to output
      if _time_to > _time_from
        _energy_part = v[2] * c[2] * (_time_to - _time_from)
      else
        # it should not enter here... probably
        _energy_part = 0.0
      end
      energy += _energy_part

      puts "#{voltage_i}, #{current_i} = #{_energy_part}, #{v.inspect}, #{c.inspect}"

      # next from array
      if c[1] > v[1]
        voltage_i += 1
      else
        current_i += 1
      end

    end

    #currents = [
    #  [1, 2] => 1,
    #  [2, 3] => 2
    #]
    #
    #voltages = [
    #  [1, 2] => 2,
    #  [2, 3] => 1
    #]


    start_time = voltages

    return energy
  end

end
