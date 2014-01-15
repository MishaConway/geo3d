require 'spec_helper'

describe Geo3d::Plane do
  def random_matrix
    r = Geo3d::Matrix.new
    for i in 0..3
      for j in 0..3
        r[i, j] = rand 10000
      end
    end
    r
  end

  def random_vector
    v = Geo3d::Vector.new
    v.x = rand 10000
    v.y = rand 10000
    v.z = rand 10000
    v.w = rand 10000
    v
  end


  it "should default all values to zero" do
    Geo3d::Matrix.new.to_a.select(&:zero?).size.should == 16
  end

  it "should be able to extract translation component" do

  end

  it "should be able to extract scaling component" do

  end

  it "should be able to extract rotation component" do

  end

  it "should be invertible" do
    100.times do
      r = random_matrix
      (r * r.inverse).identity?.should == true
    end
  end

  it "should return the determinant" do

  end

  it "should be transposable" do

  end

  it "should have an identity constructor" do
    identity = Geo3d::Matrix.identity
    identity.identity?.should == true
  end

  it "should have a right handed perspective projection constructor" do

  end

  it "should have a left handed perspective projection constructor" do

  end

  it "should have a right handed orthographic projection constructor" do

  end

  it "should have a left handed orthographic projection constructor" do

  end

  it "should have a right handed view constructor" do

  end

  it "should have a left handed view constructor" do

  end

  it "should have a translation constructor" do

  end

  it "should have a scaling constructor" do

  end


  it "should have an x-axis rotation constructor" do
    [{:angle => 1, :expected => [1.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.540302, 0.841471, 0.000000, 0.000000, -0.841471, 0.540302, 0.000000, 0.000000, 0.000000, 0.000000, 1.000000]},
     {:angle => 3.2, :expected => [1.000000, 0.000000, 0.000000, 0.000000, 0.000000, -0.998295, -0.058374, 0.000000, 0.000000, 0.058374, -0.998295, 0.000000, 0.000000, 0.000000, 0.000000, 1.000000]}].each do |data|
      matrix = Geo3d::Matrix.rotation_x data[:angle]
      data[:expected].size.should == 16
      expected = Geo3d::Matrix.new *data[:expected]
      matrix.should == expected
    end
  end

  it "should have an y-axis rotation constructor" do
    [{:angle => 1, :expected => [0.540302, 0.000000, -0.841471, 0.000000, 0.000000, 1.000000, 0.000000, 0.000000, 0.841471, 0.000000, 0.540302, 0.000000, 0.000000, 0.000000, 0.000000, 1.000000]},
     {:angle => 3.2, :expected => [-0.998295, 0.000000, 0.058374, 0.000000, 0.000000, 1.000000, 0.000000, 0.000000, -0.058374, 0.000000, -0.998295, 0.000000, 0.000000, 0.000000, 0.000000, 1.000000]}].each do |data|
      matrix = Geo3d::Matrix.rotation_y data[:angle]
      data[:expected].size.should == 16
      expected = Geo3d::Matrix.new *data[:expected]
      matrix.should == expected
    end
  end

  it "should have a z-axis rotation constructor" do
    [{:angle => 1, :expected => [0.540302, 0.841471, 0.000000, 0.000000, -0.841471, 0.540302, 0.000000, 0.000000, 0.000000, 0.000000, 1.000000, 0.000000, 0.000000, 0.000000, 0.000000, 1.000000]},
     {:angle => 3.2, :expected => [-0.998295, -0.058374, 0.000000, 0.000000, 0.058374, -0.998295, 0.000000, 0.000000, 0.000000, 0.000000, 1.000000, 0.000000, 0.000000, 0.000000, 0.000000, 1.000000]}].each do |data|
      matrix = Geo3d::Matrix.rotation_z data[:angle]
      data[:expected].size.should == 16
      expected = Geo3d::Matrix.new *data[:expected]
      matrix.should == expected
    end
  end

  it "should have an arbitrary axis rotation constructor" do
    [{:axis => [1,1,0], :angle => 88.7, :expected => [0.870782,0.129218,-0.474385,0.000000,0.129218,0.870782,0.474385,0.000000,0.474385,-0.474385,0.741564,0.000000,0.000000,0.000000,0.000000,1.000000]}].each do |data|
      matrix = Geo3d::Matrix.rotation Geo3d::Vector.new(*data[:axis]), data[:angle]
      data[:expected].size.should == 16
      expected = Geo3d::Matrix.new *data[:expected]
      matrix.should == expected
    end
  end

  it "should have a reflection constructor" do
    [{:plane => [1, 1, 1, 1], :expected => []}].each do |data|
      matrix = Geo3d::Matrix.reflection Geo3d::Plane.new(*data[:plane])
      data[:expected].size.should == 16
      expected = Geo3d::Matrix.new *data[:expected]
      matrix.should == expected
    end
  end

  it "should have a shadow constructor" do
    [{:plane => [1, 1, 1, 1], :light_pos => [1, 1, 1, 1], :expected => []}].each do |data|
      matrix = Geo3d::Matrix.shadow Geo3d::Vector.new(*data[:light_pos]), Geo3d::Plane.new(*data[:plane])
      data[:expected].size.should == 16
      expected = Geo3d::Matrix.new *data[:expected]
      matrix.should == expected
    end
  end


  it "should transform vectors" do

  end

  it "multiplying a matrix by the identity matrix should result in the same matrix" do
    identity = Geo3d::Matrix.identity
    10.times do
      r = random_matrix
      (r * identity).should == r
      (identity * r).should == r
    end
  end

  it "should multiply with other matrices" do

  end
end