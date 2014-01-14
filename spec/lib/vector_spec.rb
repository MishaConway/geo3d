require 'spec_helper'

describe Geo3d::Vector do
  it "should default all values to zero" do
    v = Geo3d::Vector.new
    v.x.zero?.should == true
    v.y.zero?.should == true
    v.z.zero?.should == true
    v.w.zero?.should == true
  end

  it "should support dot products with other vectors" do
    [{:a => [1, 1, 1, 1], :b => [2, 2, 2, 2], :expected => 8},
     {:a => [0, 1, 0, -99], :b => [0, -42, 2, 52], :expected => -5190},
     {:a => [91, -2731, 1, 123], :b => [2, 7, -9, 2], :expected => -18698},
    ].each do |data|
      a = Geo3d::Vector.new *data[:a]
      b = Geo3d::Vector.new *data[:b]
      Geo3d::Utils.float_cmp(a.dot(b), data[:expected]).should == true
    end
  end

  it "should support cross products with other vectors" do

  end

  it "should return length" do

  end

  it "should return length squared" do

  end

  it "should be normalizable" do
    [{:vector => [0, 0, -1, 3], :expected => [0, 0, -0.316228, 0.948683]},
     {:vector => [11, 11, -7, 3], :expected => [0.635085, 0.635085, -0.404145, 0.173205]},
     {:vector => [-56, 23, 923, 9], :expected => [-0.060539, 0.024864, 0.997809, 0.009729]}].each do |data|
      vector = Geo3d::Vector.new(*data[:vector]).normalize
      expected = Geo3d::Vector.new *data[:expected]
      vector.should == expected
    end
  end

  it "should be able to linearly interpolate" do

  end

end