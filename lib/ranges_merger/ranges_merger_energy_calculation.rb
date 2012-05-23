class RangesMerger

  def self.energy_calculation(voltages, currents)
    return 0 if voltages.size == 0 or currents.size == 0

    # sort time ranges
    voltages_ranges = voltages.keys.sort{|a,b| a[0] <=> [b]}
    current_ranges = currents.keys.sort{|a,b| a[0] <=> [b]}

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
