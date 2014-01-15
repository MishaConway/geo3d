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
    [{:fovy => 2, :aspect => 2, :zn => 2, :zf => 21000, :expected => [0.321046, 0.000000, 0.000000, 0.000000, 0.000000, 0.642093, 0.000000, 0.000000, 0.000000, 0.000000, -1.000095, -1.000000, 0.000000, 0.000000, -2.000190, 0.000000]}].each do |data|
      matrix = Geo3d::Matrix.perspective_fov_rh data[:fovy], data[:aspect], data[:zn], data[:zf]
      data[:expected].size.should == 16
      expected = Geo3d::Matrix.new *data[:expected]
      matrix.should == expected
    end
  end


  it "should have a left handed perspective projection constructor" do
    [{:fovy => 2, :aspect => 2, :zn => 2, :zf => 21000, :expected => [0.321046, 0.000000, 0.000000, 0.000000, 0.000000, 0.642093, 0.000000, 0.000000, 0.000000, 0.000000, 1.000095, 1.000000, 0.000000, 0.000000, -2.000190, 0.000000]}].each do |data|
      matrix = Geo3d::Matrix.perspective_fov_lh data[:fovy], data[:aspect], data[:zn], data[:zf]
      data[:expected].size.should == 16
      expected = Geo3d::Matrix.new *data[:expected]
      matrix.should == expected
    end
  end


  it "should have a right handed orthographic projection constructor" do
    [{:l => -100, :r => 100, :b => -200, :t => 200, :zn => 1, :zf => 2000, :expected => [0.010000, 0.000000, 0.000000, 0.000000, 0.000000, 0.005000, 0.000000, 0.000000, 0.000000, 0.000000, -0.000500, 0.000000, -0.000000, -0.000000, -0.000500, 1.000000]}].each do |data|
      matrix = Geo3d::Matrix.ortho_off_center_rh data[:l], data[:r], data[:b], data[:t], data[:zn], data[:zf]
      data[:expected].size.should == 16
      expected = Geo3d::Matrix.new *data[:expected]
      matrix.should == expected
    end
  end


  it "should have a left handed orthographic projection constructor" do
    [{:l => -100, :r => 100, :b => -200, :t => 200, :zn => 1, :zf => 2000, :expected => [0.010000, 0.000000, 0.000000, 0.000000, 0.000000, 0.005000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000500, 0.000000, -0.000000, -0.000000, -0.000500, 1.000000]}].each do |data|
      matrix = Geo3d::Matrix.ortho_off_center_lh data[:l], data[:r], data[:b], data[:t], data[:zn], data[:zf]
      data[:expected].size.should == 16
      expected = Geo3d::Matrix.new *data[:expected]
      matrix.should == expected
    end
  end


  it "should have a right handed view constructor" do
    [{:eye => [1, 2, 3], :focus => [200, 700, 88], :up => [0, 1, 0], :expected => [-0.392804, -0.878379, -0.272314, 0.000000, 0.000000, 0.296115, -0.955152, 0.000000, 0.919622, -0.375187, -0.116315, 0.000000, -2.366064, 1.411711, 2.531564, 1.000000]}].each do |data|
      matrix = Geo3d::Matrix.look_at_rh Geo3d::Vector.new(*data[:eye]), Geo3d::Vector.new(*data[:focus]), Geo3d::Vector.new(*data[:up])
      data[:expected].size.should == 16
      expected = Geo3d::Matrix.new *data[:expected]
      matrix.should == expected
    end
  end


  it "should have a left handed view constructor" do
    [{:eye => [1, 2, 3], :focus => [200, 700, 88], :up => [0, 1, 0], :expected => [0.392804, -0.878379, 0.272314, 0.000000, 0.000000, 0.296115, 0.955152, 0.000000, -0.919622, -0.375187, 0.116315, 0.000000, 2.366064, 1.411711, -2.531564, 1.000000]}].each do |data|
      matrix = Geo3d::Matrix.look_at_lh Geo3d::Vector.new(*data[:eye]), Geo3d::Vector.new(*data[:focus]), Geo3d::Vector.new(*data[:up])
      data[:expected].size.should == 16
      expected = Geo3d::Matrix.new *data[:expected]
      matrix.should == expected
    end
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
    [{:axis => [1, 1, 0], :angle => 88.7, :expected => [0.870782, 0.129218, -0.474385, 0.000000, 0.129218, 0.870782, 0.474385, 0.000000, 0.474385, -0.474385, 0.741564, 0.000000, 0.000000, 0.000000, 0.000000, 1.000000]}].each do |data|
      matrix = Geo3d::Matrix.rotation Geo3d::Vector.new(*data[:axis]), data[:angle]
      data[:expected].size.should == 16
      expected = Geo3d::Matrix.new *data[:expected]
      matrix.should == expected
    end
  end

  it "should have a reflection constructor" do
    [{:plane => [0, 1, 0, 0], :expected => [1.000000,0.000000,0.000000,0.000000,0.000000,-1.000000,0.000000,0.000000,0.000000,0.000000,1.000000,0.000000,0.000000,0.000000,0.000000,1.000000]},
     {:plane => [0, 1, 0, 1], :expected => [1.000000,0.000000,0.000000,0.000000,0.000000,-1.000000,0.000000,0.000000,0.000000,0.000000,1.000000,0.000000,0.000000,-2.000000,0.000000,1.000000]}].each do |data|
      matrix = Geo3d::Matrix.reflection Geo3d::Plane.new(*data[:plane])
      data[:expected].size.should == 16
      expected = Geo3d::Matrix.new *data[:expected]
      matrix.should == expected
    end
  end

  it "should have a shadow constructor" do
    [{:plane => [0, 1, 0, 1], :light_pos => [0, 700, 0, 1], :expected => [701.000000,0.000000,0.000000,0.000000,0.000000,1.000000,0.000000,-1.000000,0.000000,0.000000,701.000000,0.000000,0.000000,-700.000000,0.000000,700.000000]}].each do |data|
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