require 'spec_helper'

describe RangesMergerDividerEqInterval do

  it "should divide into ranges w/o changing 'interval'" do
    a = [[0, 10]]
    b = [[1, 2]]

    r = RangesMerger.new
    r += a
    r -= b

    result = r.divide_eqi(2)
    result.should == [[2, 4], [4, 6], [6, 8], [8, 10]]
  end

  it "should divide into ranges w/o changing 'interval' (2)" do
    a = [[0, 10]]
    b = [[1, 2], [5, 6], [8, 9]]

    r = RangesMerger.new
    r += a
    r -= b

    result = r.divide_eqi(2)
    result.should == [[2, 4], [6, 8]]
  end

  it 'readme' do
    r = RangesMerger.new
    r += [[1, 9]]
    r -= [[1, 2], [4, 5]]
    result = r % 2
    #puts result.inspect

    result = r / 2
    #puts result.inspect

    result = r.divide_eqi(2)
    #puts result.inspect
  end

end
