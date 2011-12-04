require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "RangesMerger" do
  it "should merge 2 overlapping ranges" do
    a = [1, 3]
    b = [2, 4]
    result = RangesMerger.two_way_merge([a, b])
    result.should == [[1, 4]]
  end

  it "should merge 2 overlapping ranges" do
    a = [2, 4]
    b = [1, 3]
    result = RangesMerger.two_way_merge([a, b])
    result.should == [[1, 4]]
  end

  it "should merge 2 not overlapping ranges" do
    b = [1, 3]
    a = [5, 6]
    # it sorts :)
    result = RangesMerger.two_way_merge([a, b])
    result.should == [[1, 3], [5, 6]]
    result.should_not == [[5, 6], [1, 3]]
  end

  it "should merge 2 not overlapping ranges" do
    a = [1, 3]
    b = [5, 6]
    result = RangesMerger.two_way_merge([a, b])
    result.should == [[1, 3], [5, 6]]
  end

  it "should merge 2 identical ranges" do
    a = [1, 2]
    b = [1, 2]
    result = RangesMerger.two_way_merge([a, b])
    result.should == [[1, 2]]
  end

  it "should merge 2 ranges, A within B" do
    a = [1, 5]
    b = [2, 3]
    result = RangesMerger.two_way_merge([a, b])
    result.should == [[1, 5]]
  end

  it "should merge 2 ranges, B within A" do
    b = [1, 5]
    a = [2, 3]
    result = RangesMerger.two_way_merge([a, b])
    result.should == [[1, 5]]
  end

  it "should merge 3 ranges (simple)" do
    ranges = [[1,2],[2,3],[3,4]]
    result = RangesMerger.merge(ranges)
    result.should == [[1, 4]]
  end

  it "should merge 3 ranges" do
    ranges = [[0,3], [3,4],[1,2], [10,14], [12,13]]
    result = RangesMerger.merge(ranges)
    result.should == [[0, 4],[10,14]]
  end


end
