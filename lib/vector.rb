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

    def self.point *args
      self.new(*args).one_w
    end

    def self.direction *args
      self.new(*args).zero_w
    end

    def zero_w
      self.class.new x, y, z, 0
    end

    def one_w
      self.class.new x, y, z, 1
    end

    def xyz
      self.class.new x, y, z
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
      self.class.new x + vec.x, y + vec.y, z + vec.z, w
    end

    def - vec
      self.class.new x - vec.x, y - vec.y, z - vec.z, w
    end

    def * scalar
      self.class.new x * scalar, y * scalar, z * scalar, w
    end

    def / scalar
      self.class.new x / scalar, y / scalar, z / scalar, w
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
      l = self + (vec - self)*s
      l.w = w + (vec.w - w)*s
      l
    end
  end
end

