require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "RangesMerger" do
  it "should merge 2 overlapping" do
    a = [1, 3]
    b = [2, 4]
    result = RangesMerger.two_way_merge([a, b])
    result.should == [[1, 4]]
  end

  it "should merge 2 not overlapping" do
    a = [1, 3]
    b = [5, 6]
    result = RangesMerger.two_way_merge([a, b])
    result.should == [[1, 3], [5, 6]]
  end

  it "should merge 2 identical" do
    a = [1, 2]
    b = [1, 2]
    result = RangesMerger.two_way_merge([a, b])
    result.should == [[1, 2]]
  end

  it "should merge 2 overlapping" do
    a = [2, 4]
    b = [1, 3]
    result = RangesMerger.two_way_merge([a, b])
    result.should == [[1, 4]]
  end
end
