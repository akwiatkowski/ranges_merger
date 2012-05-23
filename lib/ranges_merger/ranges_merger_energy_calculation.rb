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

    voltage_first = true
    voltage_first = false if currents[0][0] < voltages[0][0]

    while voltage_i < voltages.size and current_i < currents.size
      v = voltages[voltage_i]
      c = currents[current_i]

      puts v.inspect, c.inspect
      return 0

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

    return 0
  end

end
