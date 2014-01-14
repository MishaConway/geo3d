require 'spec_helper'

describe Geo3d::Plane do
  it "should default all values to zero" do
    p = Geo3d::Plane.new
    p.a.zero?.should == true
    p.b.zero?.should == true
    p.c.zero?.should == true
    p.d.zero?.should == true
  end

  it "should construct from a point and a normal" do
    [{:point => [0, 0, 0], :normal => [0, 1, 0], :expected => [0, 1, 0, 0]},
     {:point => [1, 2, 3], :normal => [1, 1, 1], :expected => [1, 1, 1, -6]},
     {:point => [221, 772, 33], :normal => [2, 0, 1], :expected => [2, 0, 1, -475]},
     {:point => [999, 888, 777], :normal => [-1, 3, 0], :expected => [-1, 3, 0, -1665]}].each do |data|
      plane = Geo3d::Plane.from_point_and_normal Geo3d::Vector.new(*data[:point]), Geo3d::Vector.new(*data[:normal])
      expected = Geo3d::Plane.new *data[:expected]
      plane.should == expected
    end
  end

  it "should construct from points" do
    [{:a => [1, 1, 1], :b => [2, 2, 2], :c => [3, 3, 3], :expected => [0, 0, 0, 0]},
     {:a => [-1.5, 1.5, 3.0, 0], :b => [1.5, 1.5, 3.0, 0], :c => [-1.5, -1.5, 3.0, 0], :expected => [0, 0, -1, 3]},
     {:a => [10, 1, 33], :b => [1, 11, 3], :c => [-1, -1, 3], :expected => [-0.930808, 0.155135, 0.330954, -1.768534]}].each do |data|
      plane = Geo3d::Plane.from_points Geo3d::Vector.new(*data[:a]), Geo3d::Vector.new(*data[:b]), Geo3d::Vector.new(*data[:c])
      expected = Geo3d::Plane.new *data[:expected]
      plane.should == expected
    end
  end

  it "should support dot products with vectors" do
    [{:plane => [1, 1, 1, 1], :vector => [2, 2, 2, 2], :expected => 8},
     {:plane => [0, 1, 0, -99], :vector => [0, -42, 2, 52], :expected => -5190},
     {:plane => [91, -2731, 1, 123], :vector => [2, 7, -9, 2], :expected => -18698},
    ].each do |data|
      plane = Geo3d::Plane.new *data[:plane]
      vector = Geo3d::Vector.new *data[:vector]
      Geo3d::Utils.float_cmp(plane.dot(vector), data[:expected]).should == true
    end
  end

  it "should be normalizable" do
    [{:plane => [0, 0, -1, 3], :expected => [0, 0, -1, 3]},
     {:plane => [11, 11, -7, 3], :expected => [0.644831, 0.644831, -0.410347, 0.175863]},
     {:plane => [-56, 23, 923, 9], :expected => [-0.060542, 0.024865, 0.997856, 0.009730]}].each do |data|
      plane = Geo3d::Plane.new(*data[:plane]).normalize
      expected = Geo3d::Plane.new *data[:expected]
      plane.should == expected
    end
  end

  it "should be able to detect line intersections" do
    [{:plane => [0,0,-1,3], :line_start => [1,1,1,0], :line_end => [2,2,2,0], :expected => [3,3,3,0]},
     {:plane => [0,0,-1,3], :line_start => [1,1,1,1], :line_end => [2,2,2,1], :expected => [3,3,3,1]},
     {:plane => [0,1,0,-30], :line_start => [1,0,0,0], :line_end => [2,0,0,0], :expected => nil},
     {:plane => [0,1,0,-30], :line_start => [1,1,0,0], :line_end => [2,0,0,0], :expected => [-28,30,0,0]},
     {:plane => [0,1,0,-30], :line_start => [1,1,0,1], :line_end => [2,0,0,1], :expected => [-28,30,0,1]}].each do |data|
      plane = Geo3d::Plane.new *data[:plane]
      line_start = Geo3d::Vector.new *data[:line_start]
      line_end = Geo3d::Vector.new *data[:line_end]
      if data[:expected]
        expected = Geo3d::Vector.new *data[:expected]
      else
        expected = nil
      end
      plane.line_intersection(line_start, line_end).should == expected
    end
  end

  it "should be transformable" do
    test_transform = ->(matrix, plane,expected) do
      plane.transform(matrix).should == expected
    end
    test_transform.call Geo3d::Matrix.translation(0,5,0), Geo3d::Plane.new(0,1,0,0), Geo3d::Plane.new(0,1,0,-5)
    test_transform.call Geo3d::Matrix.translation(0,5,0), Geo3d::Plane.new(1,1,1,1), Geo3d::Plane.new(1,1,1,-4)
    test_transform.call Geo3d::Matrix.rotation_x(1), Geo3d::Plane.new(1,1,1,1), Geo3d::Plane.new(1.000000, -0.301169, 1.381773, 1.000000)
  end
end
