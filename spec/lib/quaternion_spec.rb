require 'spec_helper'

describe Geo3d::Quaternion do
  it "should default all values to zero" do
    q = Geo3d::Quaternion.new
    q.x.zero?.should == true
    q.y.zero?.should == true
    q.z.zero?.should == true
    q.w.zero?.should == true
  end

  it "should be constructable from an axis and angle" do
    [{:axis => [0, 1, 0], :angle => 1, :expected => [0.000000, 0.479426, 0.000000, 0.877583]},
     {:axis => [0, -1, 0], :angle => 1, :expected => [0.000000, -0.479426, 0.000000, 0.877583]},
     {:axis => [0, 1, 0], :angle => -1, :expected => [0.000000, -0.479426, 0.000000, 0.877583]},
     {:axis => [0, 1, 0], :angle => -6, :expected => [-0.000000, -0.141120, -0.000000, -0.989992]},
     {:axis => [-213, 133, 22, -232], :angle => -3432, :expected => [0.538065, -0.335975, -0.055575, 0.771050]}].each do |data|
      Geo3d::Quaternion.from_axis(Geo3d::Vector.new(*data[:axis]), data[:angle]).should == Geo3d::Quaternion.new(*data[:expected])
    end
  end

  it "should be constructable from a rotation matrix" do
    Geo3d::Quaternion.from_matrix(Geo3d::Matrix.rotation_x 1).should == Geo3d::Quaternion.new(0.479426, 0.000000, -0.000000, 0.877583)
    Geo3d::Quaternion.from_matrix(Geo3d::Matrix.rotation_y 1).should == Geo3d::Quaternion.new(-0.000000, 0.479426, -0.000000, 0.877583)
    Geo3d::Quaternion.from_matrix(Geo3d::Matrix.rotation_z 1).should == Geo3d::Quaternion.new(-0.000000, 0.000000, 0.479426, 0.877583)
    Geo3d::Quaternion.from_matrix(Geo3d::Matrix.rotation_x 3.2).should == Geo3d::Quaternion.new(0.999574, 0.000000, 0.000000, -0.029200)
  end

  it "should be able to construct as the identity quaternion" do
    q = Geo3d::Quaternion.identity
    q.should == Geo3d::Quaternion.new(0, 0, 0, 1)
    q.identity?.should == true
  end

  it "should be able to convert to a rotation matrix" do

  end

  it "should return axis of rotation" do
    for i in 0..10000
      angle = 0.1 * i + 0.1
     # puts "angle is #{angle}"
      #Geo3d::Quaternion.from_matrix(Geo3d::Matrix.rotation_x angle).axis.should == Geo3d::Vector.new(1, 0, 0)
      #Geo3d::Quaternion.from_matrix(Geo3d::Matrix.rotation_y angle).axis.should == Geo3d::Vector.new(0, 1, 0)
      #Geo3d::Quaternion.from_matrix(Geo3d::Matrix.rotation_z angle).axis.should == Geo3d::Vector.new(0, 0, 1)
    end
  end

  it "should return rotation amount as angle" do

  end

  it "should return conjugate" do
    [{:quaternion => [1, 1, 1, 1], :expected => [-1, -1, -1, 1]}].each do |data|
      quaternion = Geo3d::Quaternion.new *data[:quaternion]
      expected = Geo3d::Quaternion.new *data[:expected]
      quaternion.conjugate.should == expected
    end
  end

  it "should return inverse" do
    [{:quaternion => [1, 1, 1, 1], :expected => [-0.250000, -0.250000, -0.250000, 0.250000]},
     {:quaternion => [-1, -1, -1, -1], :expected => [0.250000, 0.250000, 0.250000, -0.250000]}].each do |data|
      quaternion = Geo3d::Quaternion.new *data[:quaternion]
      expected = Geo3d::Quaternion.new *data[:expected]
      quaternion.inverse.should == expected
    end
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