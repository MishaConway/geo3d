module Geo3d
  class Vector
    attr_accessor :x, :y, :z, :w

    def initialize *args
      @x, @y, @z, @w = 0, 0, 0, 0
      @x = args[0] if args.size > 0
      @y = args[1] if args.size > 1
      @z = args[2] if args.size > 2
      @w = args[3] if args.size > 3
    end

    def to_s
      to_a.compact.join ' '
    end

    def to_a
      [x, y, z, w]
    end

    def +@
      self * 1
    end

    def -@
      self * -1
    end

    def + vec
      self.class.new x + vec.x, y + vec.y, z + vec.z, w + vec.w
    end

    def - vec
      self.class.new x - vec.x, y - vec.y, z - vec.z, w - vec.w
    end

    def * scalar
      self.class.new x * scalar, y * scalar, z * scalar, w * scalar
    end

    def / scalar
      self.class.new x / scalar, y / scalar, z / scalar, w / scalar
    end

    def == vec
      x == vec.x && y == vec.y && z == vec.z && w == vec.w
    end

    def != vec
      x != vec.x || y != vec.y || z != vec.z || w != vec.w
    end

    def cross vec
      self.class.new y * vec.z - z * vec.y, z * vec.x - x * vec.z, x * vec.y - y * vec.x
    end

    def dot vec
      x * vec.x + y * vec.y + z * vec.z
    end

    def normalize!
      len = length
      if length > 0
        @x /= len
        @y /= len
        @z /= len
      end
    end

    def normalize
      v = self.class.new x, y, z
      v.normalize!
      v
    end

    def length
      Math.sqrt length_squared
    end

    def length_squared
      dot self
    end

    def lerp vec, s
      self + ( vec - self )*s;
    end
  end
end