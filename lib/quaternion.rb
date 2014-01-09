module Geo3d
  class Quaternion
    attr_reader :x, :y, :z, :w

    def initialize rotation_axis = nil, radians = 0
      @x = @y = @z = @w = 0

      if rotation_axis

        normalized_rotation_axis = rotation_axis.normalize
        #const float radians = GeoConvertToRadians( degrees );
        @x = Math.sin(radians / 2.0) * normalized_rotation_axis.x
        @y = Math.sin(radians / 2.0) * normalized_rotation_axis.y
        @z = Math.sin(radians / 2.0) * normalized_rotation_axis.z
        @w = Math.cos(radians / 2.0);
      end
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
      Vector.new(x, y, z).normalize
    end

    def angle
      Math.acos(w) * 2.0
    end
  end
end