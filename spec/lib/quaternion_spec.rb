require 'spec_helper'

describe Geo3d::Vector do
  it "should default all values to zero" do
    q = Geo3d::Quaternion.new
    q.x.zero?.should == true
    q.y.zero?.should == true
    q.z.zero?.should == true
    q.w.zero?.should == true
  end

  it "should support dot products with other quaternions" do
    [{:a => [1, 1, 1, 1], :b => [2, 2, 2, 2], :expected => 8},
     {:a => [0, 1, 0, -99], :b => [0, -42, 2, 52], :expected => -5190},
     {:a => [91, -2731, 1, 123], :b => [2, 7, -9, 2], :expected => -18698},
    ].each do |data|
      a = Geo3d::Quaternion.new *data[:a]
      b = Geo3d::Quaternion.new *data[:b]
      Geo3d::Utils.float_cmp(a.dot(b), data[:expected]).should == true
    end
  end

  it "should return length" do
    [{:quaternion => [0, 0, -1, 3], :expected => 3.162278},
     {:quaternion => [11, 11, -7, 3], :expected => 17.320509},
     {:quaternion => [-56, 23, 923, 9], :expected => 925.027039}].each do |data|
      quaternion = Geo3d::Quaternion.new *data[:quaternion]
      expected = data[:expected]
      Geo3d::Utils.float_cmp(quaternion.length, expected).should == true
    end
  end

  it "should return length squared" do
    [{:quaternion => [0, 0, -1, 3], :expected => 10},
     {:quaternion => [11, 11, -7, 3], :expected => 300},
     {:quaternion => [-56, 23, 923, 9], :expected => 855675}].each do |data|
      quaternion = Geo3d::Quaternion.new *data[:quaternion]
      expected = data[:expected]
      Geo3d::Utils.float_cmp(quaternion.length_squared, expected).should == true
    end
  end

  it "should be normalizable" do
    [{:quaternion => [0, 0, -1, 3], :expected => [0, 0, -0.316228, 0.948683]},
     {:quaternion => [11, 11, -7, 3], :expected => [0.635085, 0.635085, -0.404145, 0.173205]},
     {:quaternion => [-56, 23, 923, 9], :expected => [-0.060539, 0.024864, 0.997809, 0.009729]}].each do |data|
      quaternion = Geo3d::Quaternion.new(*data[:quaternion]).normalize
      expected = Geo3d::Quaternion.new *data[:expected]
      quaternion.should == expected
    end
  end

 #todo: add tests for quaternion interpolation

end