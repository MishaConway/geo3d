module Geo3d
  class Triangle
    attr_accessor :a, :b, :c

    def points
      [a, b, c]
    end

    def initialize *args
      @a = args.size > 0 ? args[0] : Vector.new
      @b = args.size > 1 ? args[1] : Vector.new
      @c = args.size > 2 ? args[2] : Vector.new
    end

    def flip!
      @b, @c = @c, @b
    end

    def flip
      f = clone
      f.flip!
      f
    end

    def normal
      (b - a).cross(c - a).normalize
    end

    def signed_area reference_normal = Vector.new(0,0,-1)
      sum = Vector.new 0, 0, 0, 0
      points.each_with_index do |current_point, i|
        next_point = points[(i == points.size - 1) ? 0 : i+1]
        sum += current_point.cross next_point
      end
      reference_normal.dot(sum) / 2.0
    end

    def clockwise? reference_normal = Vector.new(0,0,-1)
      signed_area( reference_normal ) > 0
    end

    def counter_clockwise? reference_normal = Vector.new(0,0,-1)
      signed_area( reference_normal ) < 0
    end

    alias :cw? :clockwise?
    alias :ccw? :counter_clockwise?
  end
end