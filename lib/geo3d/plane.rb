module Geo3d
  class Plane
    attr_accessor :a, :b, :c, :d
    alias :x :a
    alias :y :b
    alias :z :c
    alias :w :d

    def initialize *args
      @a, @b, @c, @d = 0.0, 0.0, 0.0, 0.0
      @a = args[0].to_f if args.size > 0
      @b = args[1].to_f if args.size > 1
      @c = args[2].to_f if args.size > 2
      @d = args[3].to_f if args.size > 3
    end

    def self.from_points pv1, pv2, pv3
      edge1 = pv2 - pv1
      edge2 = pv3 - pv1
      from_point_and_normal pv1, edge1.cross(edge2).normalize
    end

    def self.from_point_and_normal point, normal
      point.w = 0
      self.new normal.x, normal.y, normal.z, -point.dot(normal)
    end

    def to_a
      [a,b,c,d]
    end

    def == p
       Geo3d::Utils.float_cmp(a, p.a) && Geo3d::Utils.float_cmp(b, p.b) && Geo3d::Utils.float_cmp(c, p.c) && Geo3d::Utils.float_cmp(d, p.d)
     end

     def != vec
       !(self == vec)
     end

    def dot v
      a * v.x + b * v.y + c * v.z + d * v.w
    end

    def normalize!
      norm = Math.sqrt(a*a + b*b + c*c)
      if norm.zero?
        @a = 0
        @b = 0
        @c = 0
        @d = 0
      else
        @a /= norm
        @b /= norm
        @c /= norm
        @d /= norm
      end
    end

    def normalize
      p = self.class.new a, b, c, d
      p.normalize!
      p
    end

    def normal
      Vector.new a, b, c
    end

    def line_intersection line_start, line_end
      direction = line_end - line_start

      normal_dot_direction = normal.dot direction

      if (normal_dot_direction.zero?)
        nil
      else
        temp = (d + normal.dot(line_start)) / normal_dot_direction
        line_start - direction * temp
      end
    end

    def transform matrix, use_inverse_transpose = true
      matrix = matrix.inverse.transpose if use_inverse_transpose
      p = self.class.new
      p.a = dot matrix.row(0)
      p.b = dot matrix.row(1)
      p.c = dot matrix.row(2)
      p.d = dot matrix.row(3)
      p
    end
  end
end