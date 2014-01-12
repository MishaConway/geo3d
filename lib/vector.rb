module Geo3d
  class Vector
    attr_accessor :x, :y, :z, :w
    alias :a :x
    alias :b :y
    alias :c :z
    alias :d :w

    def initialize *args
      @x = 0.0
      @y = 0.0
      @z = 0.0
      @w = 0.0
      @x = args[0].to_f if args.size > 0
      @y = args[1].to_f if args.size > 1
      @z = args[2].to_f if args.size > 2
      @w = args[3].to_f if args.size > 3
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
      Geo3d::Utils.float_cmp(x, vec.x) && Geo3d::Utils.float_cmp(y, vec.y) && Geo3d::Utils.float_cmp(z, vec.z) && Geo3d::Utils.float_cmp(w, vec.w)
    end

    def != vec
      !(self == vec)
    end

    def cross vec
      self.class.new y * vec.z - z * vec.y, z * vec.x - x * vec.z, x * vec.y - y * vec.x
    end

    def dot vec
      x * vec.x + y * vec.y + z * vec.z + w * vec.w
    end

    def normalize!
      len = length
      if length > 0
        @x /= len
        @y /= len
        @z /= len
        @w /= len
      end
    end

    def normalize
      v = self.class.new x, y, z, w
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