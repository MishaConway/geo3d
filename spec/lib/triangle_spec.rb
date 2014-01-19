require 'spec_helper'

describe Geo3d::Triangle do
  it "should detect winding" do
    [{:a => [0,0,0], :b => [1,0,0], :c => [1,1,0], :expected => "counter-clockwise"},
     {:a => [0,0,0], :b => [1,0,0], :c => [1,-1,0], :expected => "clockwise"}].each do |data|
      t = Geo3d::Triangle.new
      t.a = Geo3d::Vector.new *data[:a]
      t.b = Geo3d::Vector.new *data[:b]
      t.c = Geo3d::Vector.new *data[:c]
      winding = t.counter_clockwise?? 'counter-clockwise' : 'clockwise'
      winding.should == data[:expected]
    end
  end

  it "should calculate normal" do

  end
end