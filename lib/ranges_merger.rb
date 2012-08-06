require 'ranges_merger/ranges_merger_merging'
require 'ranges_merger/ranges_merger_utils'
require 'ranges_merger/ranges_merger_exclusion'
require 'ranges_merger/ranges_merger_divider'
require 'ranges_merger/ranges_merger_divider_eq_interval'
require 'ranges_merger/ranges_merger_energy_calculation'

class RangesMerger
  extend RangesMergerMerging
  extend RangesMergerUtils
  extend RangesMergerExclusion
  extend RangesMergerDivider
  extend RangesMergerDividerEqInterval

  attr_reader :ranges

  def initialize(_array = [])
    @total_min = nil
    @ranges = self.class.merge(
      self.class.normalize_array(_array)
    )
  end

  def add(_array)
    register_min(_array)
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

  def divide_eqi(interval, total_min = @total_min)
    return self.class.divide_eqi(@ranges, interval, total_min)
  end

  def to_ranges
    self.class.array_to_ranges(@ranges)
  end

  def to_array
    @ranges
  end

  private

  # Hack for maintaining proper interval and start for 'divide_eqi'
  def register_min(ranges)
    _min = ranges.sort{|a,b| a[0] <=> b[0]}.first[0]
    if @total_min.nil?
      @total_min = _min
    else
      @total_min = _min if @total_min > _min
    end
  end

end