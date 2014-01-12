module Geo3d
  module Utils
    def self.float_cmp a, b, tolerance = 0.01
      (a-b).abs < tolerance
    end
  end
end