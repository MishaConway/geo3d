module Geo3d
  class Quaternion
    attr_reader :x, :y, :z, :w

    def initialize
      @x = @y = @z = @w = 0.0
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

    def self.from_axis rotation_axis, radians = 0
      normalized_rotation_axis = rotation_axis.normalize
      #const float radians = GeoConvertToRadians( degrees );

      q = self.new
      q.x = Math.sin(radians / 2.0) * normalized_rotation_axis.x
      q.y = Math.sin(radians / 2.0) * normalized_rotation_axis.y
      q.z = Math.sin(radians / 2.0) * normalized_rotation_axis.z
      q.w = Math.cos(radians / 2.0)
      q
    end

    def self.from_matrix pm
      pout = self.new

      trace = pm._11 + pm._22 + pm._33 + 1.0
      if trace > 0
        pout.x = (pm._23 - pm._32) / (2.0 * Math.sqrt(trace))
        pout.y = (pm._31 - pm._13) / (2.0 * Math.sqrt(trace))
        pout.z = (pm._12- pm._21) / (2.0 * Math.sqrt(trace))
        pout.w = Math.sqrt(trace) / 2.0
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
      pout
    end

    def * quat
      out = Quat.new
      out.w = w * quat.w - x * quat.x - y * quat.y - z * quat.z
      out.x = w * quat.x + x * quat.w + y * quat.z - z * quat.y
      out.y = w * quat.y - x * quat.z + y * quat.w + z * quat.x
      out.z = w * quat.z + x * quat.y - y * quat.x + z * quat.w
      out
    end

    def to_matrix
      v = Vector.new(x, y, z, w); ## Normalize();
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
      v = Vector.new
      v.x = x / Math.sqrt(1-w*w)
      v.y = y / Math.sqrt(1-w*w)
      v.z = z / Math.sqrt(1-w*w)
      v
    end

    def angle
      Math.acos(w) * 2.0
    end
  end
end