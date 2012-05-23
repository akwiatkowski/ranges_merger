require 'ranges_merger/ranges_merger_merging'
require 'ranges_merger/ranges_merger_utils'
require 'ranges_merger/ranges_merger_exclusion'
require 'ranges_merger/ranges_merger_divider'
require 'ranges_merger/ranges_merger_energy_calculation'

class RangesMerger
  extend RangesMergerMerging
  extend RangesMergerUtils
  extend RangesMergerExclusion
  extend RangesMergerDivider

  attr_reader :ranges

  def initialize(_array = [])
    @ranges = self.class.merge(
      self.class.normalize_array(_array)
    )
  end

  def add(_array)
    @ranges = self.class.merge(@ranges + _array)
    return self
  end

  def +(_array)
    add(_array)
  end

  def remove(_array)
    @ranges = self.class.exclude(@ranges, _array)
    return self
  end

  def -(_array)
    remove(_array)
  end

  def divide(interval, allow_partials = true)
    return self.class.divide(@ranges, interval, allow_partials)
  end

  def /(interval)
    divide(interval, true)
  end

  def %(interval)
    divide(interval, false)
  end

  def to_ranges
    self.class.array_to_ranges(@ranges)
  end

  def to_array
    @ranges
  end

end