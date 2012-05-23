require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "RangesMerger" do

  # Merging

  it "should calculate energy (1)" do
    # time_from, time_to, value

    currents = [
      [1, 2, 1],
      [2, 3, 2]
    ]

    voltages = [
      [1, 2, 2],
      [2, 3, 1]
    ]

    result = RangesMerger.energy_calculation(voltages, currents)
    result.should == 4
  end

  it "should calculate energy (2)" do
    # time_from, time_to, value

    currents = [
      [0, 1, 0],
      [2, 5, 1],
      [5, 6, 0]
    ]

    voltages = [
      [0, 1, 5],
      [2, 5, 0],
      [5, 6, 5]
    ]

    result = RangesMerger.energy_calculation(voltages, currents)
    result.should == 0
  end

  it "should calculate energy (3)" do
    # time_from, time_to, value

    currents = [
      [0, 5, 0],
      [5, 10, 1]
    ]

    voltages = [
      [0, 1, 1],
      [1, 2, 0],
      #
      [2, 3, 1],
      [3, 4, 0],
      #
      [4, 5, 1],
      [5, 6, 0],
      #
      [6, 7, 1],
      [7, 8, 0],
      #
      [8, 9, 1],
      [9, 10, 0],
    ]

    result = RangesMerger.energy_calculation(voltages, currents)
    result.should == 2
  end

  it "should calculate energy (4)" do
    # time_from, time_to, value

    currents = [
      [0, 0.1, 1],
      [0.2, 0.5, 2]
    ]

    voltages = [
      [1, 2, 1]
    ]

    result = RangesMerger.energy_calculation(voltages, currents)
    result.should == 0
  end

  it "should calculate energy (5)" do
    # time_from, time_to, value

    currents = [
      [0, 0.1, 1],
      [0.2, 0.5, 2]
    ]

    voltages = [
      [0, 1, 1]
    ]

    result = RangesMerger.energy_calculation(voltages, currents)
    result.should == 0.1 + (0.5 - 0.2) * 2
  end


end
