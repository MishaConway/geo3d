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
    [{:a => [1, 0, 0, 0], :b => [0, 1, 0, 0], :expected => [0, 0, 1, 0]},
     {:a => [1, 0, 0, 1], :b => [0, 1, 0, 1], :expected => [0, 0, 1, 0]},
     {:a => [1, 1, 1, 1], :b => [1, 1, 1, 1], :expected => [0, 0, 0, 0]},
     {:a => [2, 99, 6, 0], :b => [-11, -91, 77, 0], :expected => [8169.000000, -220.000000, 907.000000, 0.000000]}].each do |data|
      a = Geo3d::Vector.new *data[:a]
      b = Geo3d::Vector.new *data[:b]
      expected = Geo3d::Vector.new *data[:expected]
      a.cross(b).should == expected
      b.cross(a).should == -expected
    end
  end

  it "should return length" do
    [{:vector => [0, 0, -1, 3], :expected => 3.162278},
     {:vector => [11, 11, -7, 3], :expected => 17.320509},
     {:vector => [-56, 23, 923, 9], :expected => 925.027039}].each do |data|
      vector = Geo3d::Vector.new *data[:vector]
      expected = data[:expected]
      Geo3d::Utils.float_cmp(vector.length, expected).should == true
    end
  end

  it "should return length squared" do
    [{:vector => [0, 0, -1, 3], :expected => 10},
     {:vector => [11, 11, -7, 3], :expected => 300},
     {:vector => [-56, 23, 923, 9], :expected => 855675}].each do |data|
      vector = Geo3d::Vector.new *data[:vector]
      expected = data[:expected]
      Geo3d::Utils.float_cmp(vector.length_squared, expected).should == true
    end
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
    [{:a => [0, 0, 0, 0], :b => [1, 1, 1, 1], :interpolate_fraction => 0.5, :expected => [0.5, 0.5, 0.5, 0.5]},
     {:a => [23, -3, 425, -332], :b => [-22, -45443, 886, 122], :interpolate_fraction => 0.21234433, :expected => [13.444505, -9651.926758, 522.890747, -235.595673]}].each do |data|
      a = Geo3d::Vector.new *data[:a]
      b = Geo3d::Vector.new *data[:b]
      expected = Geo3d::Vector.new *data[:expected]
      s = data[:interpolate_fraction]
      a.lerp(b, s).should == expected
    end
  end

  it "should calculate reflection" do
    [{:normal => [0, 1, 0], :incident => [1, 1, 0], :expected => [1, -1, 0]},
     {:normal => [0, 1, 0], :incident => [0, -1, 0], :expected => [0, 1, 0]},
     {:normal => [22, 33, 68], :incident => [65, -23, -23], :expected => [39357.000000, 58915.000000, 121425.000000, 0.000000]}].each do |data|
      normal = Geo3d::Vector.new *data[:normal]
      incident = Geo3d::Vector.new *data[:incident]
      expected = Geo3d::Vector.new *data[:expected]
      Geo3d::Vector.reflect(normal, incident).should == expected
    end
  end

  it "should calculate refraction" do
    [{:normal => [0, 1, 0], :incident => [1, 1, 0], :index_of_ref => 0.5, :expected => [0.5, -1, 0]},
     {:normal => [0, 1, 0], :incident => [0, -1, 0], :index_of_ref => 21.345, :expected => [0, -1, 0]},
     {:normal => [22, 33, 68], :incident => [65, -23, -23], :index_of_ref => 17.5678, :expected => [1142.121826, -403.737152, -403.395355]},
     {:normal => [1, 0, 0], :incident => [0, 1, 0], :index_of_ref => 0.75, :expected => [-0.661438, 0.750000, 0.000000, 0.000000]}
    ].each do |data|

      normal = Geo3d::Vector.new *data[:normal]
      incident = Geo3d::Vector.new *data[:incident]
      expected = Geo3d::Vector.new *data[:expected]
      Geo3d::Vector.refract(normal, incident, data[:index_of_ref]).should == expected
    end
  end

end