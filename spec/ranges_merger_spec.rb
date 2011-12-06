require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "RangesMerger" do

  # Merging

  it "should merge 2 overlapping ranges" do
    a = [1, 3]
    b = [2, 4]
    result = RangesMerger.merge([a, b])
    result.should == [[1, 4]]
  end

  it "should merge 2 overlapping ranges" do
    a = [2, 4]
    b = [1, 3]
    result = RangesMerger.merge([a, b])
    result.should == [[1, 4]]
  end

  it "should merge 2 not overlapping ranges" do
    b = [1, 3]
    a = [5, 6]
    # it sorts :)
    result = RangesMerger.merge([a, b])
    result.should == [[1, 3], [5, 6]]
    result.should_not == [[5, 6], [1, 3]]
  end

  it "should merge 2 not overlapping ranges" do
    a = [1, 3]
    b = [5, 6]
    result = RangesMerger.merge([a, b])
    result.should == [[1, 3], [5, 6]]
  end

  it "should merge 2 identical ranges" do
    a = [1, 2]
    b = [1, 2]
    result = RangesMerger.merge([a, b])
    result.should == [[1, 2]]
  end

  it "should merge 2 ranges, A within B" do
    a = [1, 5]
    b = [2, 3]
    result = RangesMerger.merge([a, b])
    result.should == [[1, 5]]
  end

  it "should merge 2 ranges, B within A" do
    b = [1, 5]
    a = [2, 3]
    result = RangesMerger.merge([a, b])
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
    result = RangesMerger.merge([a, b])
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

  it "should merge Range objects" do
    ranges = [
      (1..2),
      (2..3),
      (5..8)
    ]
    result = RangesMerger.merge(ranges)
    result.should == [(1..3), (5..8)]
  end


  #Exclusion

  it "should exclude ranges 'inside' range" do
    result = RangesMerger.exclude([[1, 4]], [[2, 3]])
    result.should == [[1, 2], [3, 4]]
  end

  it "should exclude ranges at right end" do
    result = RangesMerger.exclude([[1, 4]], [[3, 4]])
    result.should == [[1, 3]]
  end

  it "should exclude ranges at left end" do
    result = RangesMerger.exclude([[1, 4]], [[1, 2]])
    result.should == [[2, 4]]
  end

  it "should exclude ranges 'outside' range" do
    result = RangesMerger.exclude([[1, 4]], [[0, 5]])
    result.should == []
  end

  it "should not exclude ranges because exclude range is 'outside' base range" do
    result = RangesMerger.exclude([[1, 4]], [[5, 6]])
    result.should == [[1, 4]]
  end

  it "should exclude using many ranges (1)" do
    result = RangesMerger.exclude([[1, 2], [3, 4], [5, 6]], [[2, 5]])
    result.should == [[1, 2], [5, 6]]
  end

  it "should exclude using many ranges (2)" do
    result = RangesMerger.exclude([[1, 2], [3, 4], [5, 6]], [[1, 6]])
    result.should == []
  end

  it "should exclude using many ranges (3)" do
    result = RangesMerger.exclude([[1, 2], [3, 4], [5, 6]], [[2, 3], [4, 5]])
    result.should == [[1, 2], [3, 4], [5, 6]]
  end

  it "should exclude using many ranges (4)" do
    result = RangesMerger.exclude([[1, 10]], [[2, 3], [4, 5], [6, 7]])
    result.should == [[1, 2], [3, 4], [5, 6], [7, 10]]
  end

  it "should exclude using many ranges (5)" do
    result = RangesMerger.exclude([[1, 4], [6, 10]], [[4, 6]])
    result.should == [[1, 4], [6, 10]]
  end

  it "should exclude using many ranges (6)" do
    result = RangesMerger.exclude([[1, 4], [6, 10]], [[3, 7]])
    result.should == [[1, 3], [7, 10]]
  end

  it "should exclude using many ranges (7)" do
    result = RangesMerger.exclude([[1, 4], [6, 10]], [[0, 7]])
    result.should == [[7, 10]]
  end

  it "should exclude using many ranges (8)" do
    result = RangesMerger.exclude([[1, 4], [6, 10]], [[8, 8]])
    result.should == [[1, 4], [6, 10]]
  end

  it "should exclude using many ranges (8)" do
    result = RangesMerger.exclude([[1, 3], [3, 5], [9, 11]], [[2, 4], [4, 10]])
    result.should == [[1, 2], [10, 11]]
  end

  # Instance

  it "should create instance, add 2 ranges and process them to array format (using add method)" do
    r = RangesMerger.new
    r.add [[1, 2]]
    r.add [[2, 3]]
    r.kind_of?(RangesMerger).should
    r.to_array.should == [[1, 3]]
  end

  it "should create instance, add 2 ranges and process them to array format (using plus operator)" do
    r = RangesMerger.new
    r += [[1, 2]]
    r += [[2, 3]]
    r.kind_of?(RangesMerger).should
    r.to_array.should == [[1, 3]]
  end


  it "should create instance, add 2 ranges, remove 2 and process them to array format (using add/remove method)" do
    r = RangesMerger.new
    r.add [[1, 10]]
    r.add [[8, 15]]
    r.to_array.should == [[1, 15]]
    
    r.remove [[2, 4]]
    r.remove [[11, 12]]
    r.kind_of?(RangesMerger).should
    r.to_array.should == [[1, 2], [4,11], [12,15]]
  end

  it "should create instance, add 2 ranges, remove 2 and process them to array format (using plus/minus operator)" do
    r = RangesMerger.new
    r += [[1, 10]]
    r += [[8, 15]]
    r.to_array.should == [[1, 15]]

    r -= [[2, 4]]
    r -= [[11, 12]]
    r.kind_of?(RangesMerger).should
    r.to_array.should == [[1, 2], [4,11], [12,15]]
  end


end
