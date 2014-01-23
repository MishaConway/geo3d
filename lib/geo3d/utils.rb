module Geo3d
  module Utils
    def self.float_cmp a, b, tolerance = 0.01
      (a-b).abs < tolerance
    end

    def self.to_degrees radians
      radians * 180.0 / Math::PI
    end

    def self.to_radians degrees
      degrees * Math::PI / 180.0
    end

    def self.normalize_angle radians
      if radians.abs > Math::PI * 2.0
        absolute = radians.abs % (Math::PI * 2.0 )
        if radians < 0
          -absolute
        else
          absolute
        end
      else
        radians
      end
    end
  end
end