require 'ranges_merger/ranges_merger_merging'
require 'ranges_merger/ranges_merger_utils'
require 'ranges_merger/ranges_merger_exclusion'

class RangesMerger
  extend RangesMergerMerging
  extend RangesMergerUtils
  extend RangesMergerExclusion

  attr_reader :ranges

  def initialize(_array)
    @ranges = RangesMerger::Merging.merge(
      self.class.normalize_array(_array)
    )
  end
end