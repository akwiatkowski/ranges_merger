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
    ranges = [[1, 2], [2, 3], [3, 4]]
    result = RangesMerger.merge(ranges)
    result.should == [[1, 4]]
  end

  it "should merge multiple (1)" do
    ranges = [[0, 3], [3, 4], [1, 2], [10, 14], [12, 13]]
    result = RangesMerger.merge(ranges)
    result.should == [[0, 4], [10, 14]]
  end

  it "should merge multiple (2)" do
    ranges = [
      [2, 4],
      [3, 5],
      [6, 9],
      [7, 8],
      [8, 9]
    ]
    result = RangesMerger.merge(ranges)
    result.should == [[2, 5], [6, 9]]
  end


  it "should merge multiple (3)" do
    ranges = [
      [2, 10],
      [3, 9],
      [4, 8],
      [5, 7],
      [6, 6]
    ]
    result = RangesMerger.merge(ranges)
    result.should == [[2, 10]]
  end


  it "should merge multiple (3)" do
    ranges = [
      [1, 100],
      [2, 200],
      [3, 500],
      [200, 201],
      [100, 2001]
    ]
    result = RangesMerger.merge(ranges)
    result.should == [[1, 2001]]
  end

  it "should do the readme code" do
    a = [1, 3]
    b = [2, 4]
    result = RangesMerger.two_way_merge([a, b])
    result.should == [[1, 4]]

    a = [1, 3]
    b = [2, 4]
    c = [4, 6]
    result = RangesMerger.merge([a, b, c])
    result.should == [[1, 6]]
  end

  it "should merge very big array" do
    ranges = Array.new
    (1..1000).each do |i|
      ranges << [i, i + 10]
    end
    result = RangesMerger.merge(ranges)
    result.should == [[1, 1000 + 10]]
  end

  it "should merge very big array (2)" do
    ranges = Array.new
    (1..1000).each do |i|
      ranges << [10*i, 10*i + 1]
    end
    result = RangesMerger.merge(ranges)
    result.size.should == 1000
    result[0][0].should == 10
    result.last[1].should == 1000*10 + 1
  end


end
