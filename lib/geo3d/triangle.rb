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

=begin  this needs to be done at a mesh level
    def tangent_and_bitangent
      return [nil, nil] unless @a.kind_of?(TexturedVertex) && @b.kind_of?(TexturedVertex) && @c.kind_of?(TexturedVertex)

      v1 = @a
      v2 = @b
      v3 = @c

      w1 = @a.texcoord
      w2 = @b.texcoord
      w3 = @c.texcoord

      x1 = v2.x - v1.x
      x2 = v3.x - v1.x
      y1 = v2.y - v1.y
      y2 = v3.y - v1.y
      z1 = v2.z - v1.z
      z2 = v3.z - v1.z

      s1 = w2.x - w1.x
      s2 = w3.x - w1.x
      t1 = w2.y - w1.y
      t2 = w3.y - w1.y

      r = 1.0 / (s1 * t2 - s2 * t1)
      tangent += Geo3d::Vector.new (t2 * x1 - t1 * x2) * r, (t2 * y1 - t1 * y2) * r, (t2 * z1 - t1 * z2) * r
      bitangent += Geo3d::Vector.new (s1 * x2 - s2 * x1) * r, (s1 * y2 - s2 * y1) * r, (s1 * z2 - s2 * z1) * r

    end
=end

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
  end
end