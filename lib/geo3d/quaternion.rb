module Geo3d
  class Quaternion
    attr_reader :x, :y, :z, :w

    def initialize *args
      @x, @y, @z, @w = 0.0, 0.0, 0.0, 0.0
      @x = args[0].to_f if args.size > 0
      @y = args[1].to_f if args.size > 1
      @z = args[2].to_f if args.size > 2
      @w = args[3].to_f if args.size > 3
    end

    def to_a
      [x,y,z,w]
    end

    def x= v
      @x = v.to_f
    end

    def y= v
      @y = v.to_f
    end

    def z= v
      @z = v.to_f
    end

    def w= v
      @w = v.to_f
    end

    def +@
      self.class.new x, y, z, w
    end

    def -@
      self.class.new -x, -y, -z, -w
    end

    def == q
      Geo3d::Utils.float_cmp(x, q.x) && Geo3d::Utils.float_cmp(y, q.y) && Geo3d::Utils.float_cmp(z, q.z) && Geo3d::Utils.float_cmp(w, q.w)
    end

    def != vec
      !(self == vec)
    end

    def self.from_axis rotation_axis, radians = 0
      radians = Geo3d::Utils.normalize_angle radians  #todo: is this cheating?....
      normalized_rotation_axis = rotation_axis.zero_w.normalize
      q = self.new
      q.x = Math.sin(radians / 2.0) * normalized_rotation_axis.x
      q.y = Math.sin(radians / 2.0) * normalized_rotation_axis.y
      q.z = Math.sin(radians / 2.0) * normalized_rotation_axis.z
      q.w = Math.cos(radians / 2.0)
      q
    end

    def self.from_axis_degrees rotation_axis, degrees = 0
      from_axis rotation_axis, Geo3d::Utils.to_radians(degrees)
    end

    def self.from_matrix pm
      pout = self.new

      #puts "trace is #{pm.trace}"
      if false && pm.trace > 1.0
        sq_root_of_trace = Math.sqrt pm.trace
        pout.x = (pm._23 - pm._32) / (2.0 * sq_root_of_trace)
        pout.y = (pm._31 - pm._13) / (2.0 * sq_root_of_trace)
        pout.z = (pm._12- pm._21) / (2.0 * sq_root_of_trace)
        pout.w = sq_root_of_trace / 2.0
        #puts "a and pout is #{pout.inspect}"

        return pout
      end
      maxi = 0
      maxdiag = pm._11


      for i in 1..2
        if pm[i, i] > maxdiag #todo: indexing might need to be fixed > maxdiag
          maxi = i
          maxdiag = pm[i, i] #todo: indexing might need to be fixed
        end
      end
      case maxi
        when 0
          s = 2.0 * Math.sqrt(1.0 + pm._11 - pm._22 - pm._33)
          pout.x = 0.25 * s
          pout.y = (pm._12 + pm._21) / s
          pout.z = (pm._13 + pm._31) / s
          pout.w = (pm._23 - pm._32) / s

        when 1
          s = 2.0 * Math.sqrt(1.0 + pm._22 - pm._11 - pm._33)
          pout.x = (pm._12 + pm._21) / s
          pout.y = 0.25 * s
          pout.z = (pm._23 + pm._32) / s
          pout.w = (pm._31 - pm._13) / s

        when 2
          s = 2.0 * Math.sqrt(1.0 + pm._33 - pm._11 - pm._22)
          pout.x = (pm._13 + pm._31) / s
          pout.y = (pm._23 + pm._32) / s
          pout.z = 0.25 * s
          pout.w = (pm._12 - pm._21) / s
      end
      #puts "b"
      pout
    end

    def + quat
      self.class.new x + quat.x, y + quat.y, z + quat.z, w + quat.w
    end

    def - quat
      self.class.new x - quat.x, y - quat.y, z - quat.z, w - quat.w
    end

    def * v
      if Quaternion == v.class
        quat = v
        out = self.class.new
        out.w = w * quat.w - x * quat.x - y * quat.y - z * quat.z
        out.x = w * quat.x + x * quat.w + y * quat.z - z * quat.y
        out.y = w * quat.y - x * quat.z + y * quat.w + z * quat.x
        out.z = w * quat.z + x * quat.y - y * quat.x + z * quat.w
        out
      else
        self.class.new x*v, y*v, z*v, w*v
      end
    end

    def / v
      self.class.new x/v, y/v, z/v, w/v
    end

    def to_matrix
      v = normalize
      matrix = Matrix.identity
      matrix._11 = 1.0 - 2.0 * (v.y * v.y + v.z * v.z)
      matrix._12 = 2.0 * (v.x * v.y + v.z * v.w)
      matrix._13 = 2.0 * (v.x * v.z - v.y * v.w)
      matrix._21 = 2.0 * (v.x * v.y - v.z * v.w)
      matrix._22 = 1.0 - 2.0 * (v.x * v.x + v.z * v.z)
      matrix._23 = 2.0 * (v.y * v.z + v.x * v.w)
      matrix._31 = 2.0 * (v.x * v.z + v.y * v.w)
      matrix._32 = 2.0 * (v.y * v.z - v.x * v.w)
      matrix._33 = 1.0 - 2.0 * (v.x * v.x + v.y * v.y)
      matrix
    end

    def axis
      Vector.new( *(normalize / Math.sin( angle / 2.0 )).to_a ).zero_w
    end

    def angle
      Math.acos(normalize.w) * 2.0
    end

    def angle_degrees
      Geo3d::Utils.to_degrees angle
    end

    def length_squared
      dot self
    end

    def length
      Math.sqrt length_squared
    end

    def dot quat
      x * quat.x + y * quat.y + z * quat.z + w * quat.w
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
      q = self.class.new x, y, z, w
      q.normalize!
      q
    end

    def conjugate
      self.class.new -x, -y, -z, w
    end

    def inverse
      norm = length_squared
      if norm.zero?
        self.class.new 0, 0, 0, 0
      else
        conjugate / norm
      end
    end

    def identity?
      self == self.class.identity
    end

    def self.identity
      self.new 0, 0, 0, 1
    end
  end
end