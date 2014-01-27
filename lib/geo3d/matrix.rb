module Geo3d
  class Matrix
    attr_accessor :_11, :_12, :_13, :_14
    attr_accessor :_21, :_22, :_23, :_24
    attr_accessor :_31, :_32, :_33, :_34
    attr_accessor :_41, :_42, :_43, :_44

    def initialize *args
      @_11 = 0
      @_12 = 0
      @_13 = 0
      @_14 = 0
      @_21 = 0
      @_22 = 0
      @_23 = 0
      @_24 = 0
      @_31 = 0
      @_32 = 0
      @_33 = 0
      @_34 = 0
      @_41 = 0
      @_42 = 0
      @_43 = 0
      @_44 = 0
      @_11 = args[0] if args.size > 0
      @_12 = args[1] if args.size > 1
      @_13 = args[2] if args.size > 2
      @_14 = args[3] if args.size > 3
      @_21 = args[4] if args.size > 4
      @_22 = args[5] if args.size > 5
      @_23 = args[6] if args.size > 6
      @_24 = args[7] if args.size > 7
      @_31 = args[8] if args.size > 8
      @_32 = args[9] if args.size > 9
      @_33 = args[10] if args.size > 10
      @_34 = args[11] if args.size > 11
      @_41 = args[12] if args.size > 12
      @_42 = args[13] if args.size > 13
      @_43 = args[14] if args.size > 14
      @_44 = args[15] if args.size > 15
    end

    def to_a
      [_11, _12, _13, _14, _21, _22, _23, _24, _31, _32, _33, _34, _41, _42, _43, _44]
    end

    def [] x, y
      to_a[4*x + y]
    end

    def []= x, y, v
      send (%w{_11 _12 _13 _14 _21 _22 _23 _24 _31 _32 _33 _34 _41 _42 _43 _44}[4*x + y] + '=').to_sym, v
    end

    def row i
      if i >= 0 && i <= 3
        Vector.new self[0, i], self[1, i], self[2, i], self[3, i]
      end
    end

    def col i
      if i >= 0 && i <= 3
        Vector.new self[i, 0], self[i, 1], self [i, 2], self[i, 3]
      end
    end

    def set_row i, v
      self[0, i] = v.x
      self[1, i] = v.y
      self[2, i] = v.z
      self[3, i] = v.w
    end

    def set_col i, v
      self[i, 0] = v.x
      self[i, 1] = v.y
      self[i, 2] = v.z
      self[i, 3] = v.w
    end

    def == m
      a = to_a
      b = m.to_a
      for i in 0..15
        return false unless Geo3d::Utils.float_cmp a[i], b[i]
      end
      true
    end

    def != m
      !(self == m)
    end

    def +@
      self * 1
    end

    def -@
      self * -1
    end

    def + mat
      sum = self.class.new

      sum._11 = _11 + mat._11
      sum._12 = _12 + mat._12
      sum._13 = _13 + mat._13
      sum._14 = _14 + mat._14

      sum._21 = _21 + mat._21
      sum._22 = _22 + mat._22
      sum._23 = _23 + mat._23
      sum._24 = _24 + mat._24

      sum._31 = _31 + mat._31
      sum._32 = _32 + mat._32
      sum._33 = _33 + mat._33
      sum._34 = _34 + mat._34

      sum._41 = _41 + mat._41
      sum._42 = _42 + mat._42
      sum._43 = _43 + mat._43
      sum._44 = _44 + mat._44

      sum
    end

    def - mat
      sum = self.class.new

      sum._11 = _11 - mat._11
      sum._12 = _12 - mat._12
      sum._13 = _13 - mat._13
      sum._14 = _14 - mat._14

      sum._21 = _21 - mat._21
      sum._22 = _22 - mat._22
      sum._23 = _23 - mat._23
      sum._24 = _24 - mat._24

      sum._31 = _31 - mat._31
      sum._32 = _32 - mat._32
      sum._33 = _33 - mat._33
      sum._34 = _34 - mat._34

      sum._41 = _41 - mat._41
      sum._42 = _42 - mat._42
      sum._43 = _43 - mat._43
      sum._44 = _44 - mat._44

      sum
    end

    def * v
      result = self.class.new

      if self.class == v.class
        matrix = v

        result._11 = _11 * matrix._11 + _12 * matrix._21 + _13 * matrix._31 + _14 * matrix._41
        result._12 = _11 * matrix._12 + _12 * matrix._22 + _13 * matrix._32 + _14 * matrix._42
        result._13 = _11 * matrix._13 + _12 * matrix._23 + _13 * matrix._33 + _14 * matrix._43
        result._14 = _11 * matrix._14 + _12 * matrix._24 + _13 * matrix._34 + _14 * matrix._44

        result._21 = _21 * matrix._11 + _22 * matrix._21 + _23 * matrix._31 + _24 * matrix._41
        result._22 = _21 * matrix._12 + _22 * matrix._22 + _23 * matrix._32 + _24 * matrix._42
        result._23 = _21 * matrix._13 + _22 * matrix._23 + _23 * matrix._33 + _24 * matrix._43
        result._24 = _21 * matrix._14 + _22 * matrix._24 + _23 * matrix._34 + _24 * matrix._44

        result._31 = _31 * matrix._11 + _32 * matrix._21 + _33 * matrix._31 + _34 * matrix._41
        result._32 = _31 * matrix._12 + _32 * matrix._22 + _33 * matrix._32 + _34 * matrix._42
        result._33 = _31 * matrix._13 + _32 * matrix._23 + _33 * matrix._33 + _34 * matrix._43
        result._34 = _31 * matrix._14 + _32 * matrix._24 + _33 * matrix._34 + _34 * matrix._44

        result._41 = _41 * matrix._11 + _42 * matrix._21 + _43 * matrix._31 + _44 * matrix._41
        result._42 = _41 * matrix._12 + _42 * matrix._22 + _43 * matrix._32 + _44 * matrix._42
        result._43 = _41 * matrix._13 + _42 * matrix._23 + _43 * matrix._33 + _44 * matrix._43
        result._44 = _41 * matrix._14 + _42 * matrix._24 + _43 * matrix._34 + _44 * matrix._44
      elsif Vector == v.class
        vec = v
        transformed_vector = Vector.new
        transformed_vector.x = _11 * vec.x + _21 * vec.y + _31 * vec.z + _41 * vec.w
        transformed_vector.y = _12 * vec.x + _22 * vec.y + _32 * vec.z + _42 * vec.w
        transformed_vector.z = _13 * vec.x + _23 * vec.y + _33 * vec.z + _43 * vec.w
        transformed_vector.w = _14 * vec.x + _24 * vec.y + _34 * vec.z + _44 * vec.w
        return transformed_vector
      elsif Triangle == v.class
        tri = v
        transformed_tri = Triangle.new
        transformed_tri.a = self * tri.a
        transformed_tri.b = self * tri.b
        transformed_tri.c = self * tri.c
        return transformed_tri
      elsif Array == v.class
        return v.map { |i| self * i }
      else
        scalar = v
        result._11 = _11 * scalar
        result._12 = _12 * scalar
        result._13 = _13 * scalar
        result._14 = _14 * scalar
        result._21 = _21 * scalar
        result._22 = _22 * scalar
        result._23 = _23 * scalar
        result._24 = _24 * scalar
        result._31 = _31 * scalar
        result._32 = _32 * scalar
        result._33 = _33 * scalar
        result._34 = _34 * scalar
        result._41 = _41 * scalar
        result._42 = _42 * scalar
        result._43 = _43 * scalar
        result._44 = _44 * scalar
      end

      result
    end

    def / v
      if self.class == v.class
        self * v.inverse
      elsif Vector == v.class
        raise 'dividing matrices by vectors not currently supported'
      else
        result = self.class.new
        scalar = v
        result._11 = _11 / scalar
        result._12 = _12 / scalar
        result._13 = _13 / scalar
        result._14 = _14 / scalar
        result._21 = _21 / scalar
        result._22 = _22 / scalar
        result._23 = _23 / scalar
        result._24 = _24 / scalar
        result._31 = _31 / scalar
        result._32 = _32 / scalar
        result._33 = _33 / scalar
        result._34 = _34 / scalar
        result._41 = _41 / scalar
        result._42 = _42 / scalar
        result._43 = _43 / scalar
        result._44 = _44 / scalar
        result
      end
    end

    def transform_coord vec
      self * Vector.new(vec.x, vec.y, vec.z, 1.0)
    end

    def transform vec
      self * vec
    end

    def identity?
      self == self.class.identity
    end

    def translation_component
      Vector.new _41, _42, _43
    end

    def scaling_component
      Vector.new Vector.new(_11, _12, _13).length, Vector.new(_21, _22, _23).length, Vector.new(_31, _32, _33).length
    end

    def rotation_component
      scaling = scaling_component
      return nil if scaling.x.zero? || scaling.y.zero? || scaling.z.zero?
      m = Matrix.new
      m._11=_11/scaling.x
      m._12=_12/scaling.x
      m._13=_13/scaling.x
      m._21=_21/scaling.y
      m._22=_22/scaling.y
      m._23=_23/scaling.y
      m._31=_31/scaling.z
      m._32=_32/scaling.z
      m._33=_33/scaling.z
      Quaternion.from_matrix m
    end

    def self.identity
      identity_matrix = self.new
      identity_matrix._12 = identity_matrix._13 = identity_matrix._14 = 0
      identity_matrix._21 = identity_matrix._23 = identity_matrix._24 = 0
      identity_matrix._31 = identity_matrix._32 = identity_matrix._34 = 0
      identity_matrix._41 = identity_matrix._42 = identity_matrix._43 = 0
      identity_matrix._11 = identity_matrix._22 = identity_matrix._33 = identity_matrix._44 = 1
      identity_matrix
    end

    def determinant
      inverse(true).last
    end

    def trace
      _11 + _22 + _33 + _44
    end

    def orthogonal?
      inverse == transpose
    end

    def is_rotation_transform?
      orthogonal? && Geo3d::Utils.float_cmp(determinant, 1.0)
    end

    def inverse with_determinant = false
      mat = to_a
      dst = Array.new 16
      tmp = Array.new 12
      src = Array.new 16

      for i in 0..3
        src[i] = mat[i*4]
        src[i + 4] = mat[i*4 + 1]
        src[i + 8] = mat[i*4 + 2]
        src[i + 12] = mat[i*4 + 3]
      end

      # calculate pairs for first 8 elements (cofactors)
      tmp[0] = src[10] * src[15]
      tmp[1] = src[11] * src[14]
      tmp[2] = src[9] * src[15]
      tmp[3] = src[11] * src[13]
      tmp[4] = src[9] * src[14]
      tmp[5] = src[10] * src[13]
      tmp[6] = src[8] * src[15]
      tmp[7] = src[11] * src[12]
      tmp[8] = src[8] * src[14]
      tmp[9] = src[10] * src[12]
      tmp[10] = src[8] * src[13]
      tmp[11] = src[9] * src[12]

      # calculate first 8 elements (cofactors)
      dst[0] = tmp[0]*src[5] + tmp[3]*src[6] + tmp[4]*src[7]
      dst[0] -= tmp[1]*src[5] + tmp[2]*src[6] + tmp[5]*src[7]
      dst[1] = tmp[1]*src[4] + tmp[6]*src[6] + tmp[9]*src[7]
      dst[1] -= tmp[0]*src[4] + tmp[7]*src[6] + tmp[8]*src[7]
      dst[2] = tmp[2]*src[4] + tmp[7]*src[5] + tmp[10]*src[7]
      dst[2] -= tmp[3]*src[4] + tmp[6]*src[5] + tmp[11]*src[7]
      dst[3] = tmp[5]*src[4] + tmp[8]*src[5] + tmp[11]*src[6]
      dst[3] -= tmp[4]*src[4] + tmp[9]*src[5] + tmp[10]*src[6]
      dst[4] = tmp[1]*src[1] + tmp[2]*src[2] + tmp[5]*src[3]
      dst[4] -= tmp[0]*src[1] + tmp[3]*src[2] + tmp[4]*src[3]
      dst[5] = tmp[0]*src[0] + tmp[7]*src[2] + tmp[8]*src[3]
      dst[5] -= tmp[1]*src[0] + tmp[6]*src[2] + tmp[9]*src[3]
      dst[6] = tmp[3]*src[0] + tmp[6]*src[1] + tmp[11]*src[3]
      dst[6] -= tmp[2]*src[0] + tmp[7]*src[1] + tmp[10]*src[3]
      dst[7] = tmp[4]*src[0] + tmp[9]*src[1] + tmp[10]*src[2]
      dst[7] -= tmp[5]*src[0] + tmp[8]*src[1] + tmp[11]*src[2]

      # calculate pairs for second 8 elements (cofactors)
      tmp[0] = src[2]*src[7]
      tmp[1] = src[3]*src[6]
      tmp[2] = src[1]*src[7]
      tmp[3] = src[3]*src[5]
      tmp[4] = src[1]*src[6]
      tmp[5] = src[2]*src[5]
      tmp[6] = src[0]*src[7]
      tmp[7] = src[3]*src[4]
      tmp[8] = src[0]*src[6]
      tmp[9] = src[2]*src[4]
      tmp[10] = src[0]*src[5]
      tmp[11] = src[1]*src[4]

      # calculate second 8 elements (cofactors)
      dst[8] = tmp[0]*src[13] + tmp[3]*src[14] + tmp[4]*src[15]
      dst[8] -= tmp[1]*src[13] + tmp[2]*src[14] + tmp[5]*src[15]
      dst[9] = tmp[1]*src[12] + tmp[6]*src[14] + tmp[9]*src[15]
      dst[9] -= tmp[0]*src[12] + tmp[7]*src[14] + tmp[8]*src[15]
      dst[10] = tmp[2]*src[12] + tmp[7]*src[13] + tmp[10]*src[15]
      dst[10]-= tmp[3]*src[12] + tmp[6]*src[13] + tmp[11]*src[15]
      dst[11] = tmp[5]*src[12] + tmp[8]*src[13] + tmp[11]*src[14]
      dst[11]-= tmp[4]*src[12] + tmp[9]*src[13] + tmp[10]*src[14]
      dst[12] = tmp[2]*src[10] + tmp[5]*src[11] + tmp[1]*src[9]
      dst[12]-= tmp[4]*src[11] + tmp[0]*src[9] + tmp[3]*src[10]
      dst[13] = tmp[8]*src[11] + tmp[0]*src[8] + tmp[7]*src[10]
      dst[13]-= tmp[6]*src[10] + tmp[9]*src[11] + tmp[1]*src[8]
      dst[14] = tmp[6]*src[9] + tmp[11]*src[11] + tmp[3]*src[8]
      dst[14]-= tmp[10]*src[11] + tmp[2]*src[8] + tmp[7]*src[9]
      dst[15] = tmp[10]*src[10] + tmp[4]*src[8] + tmp[9]*src[9]
      dst[15]-= tmp[8]*src[9] + tmp[11]*src[10] + tmp[5]*src[8]

      # calculate determinant
      det=src[0]*dst[0]+src[1]*dst[1]+src[2]*dst[2]+src[3]*dst[3]


      # calculate matrix inverse
      inverse_det = 1.0/det
      for j in 0..15
        dst[j] *= inverse_det
      end

      inverted_matrix = self.class.new *dst

      if with_determinant
        [inverted_matrix, det]
      else
        inverted_matrix
      end
    end

    def transpose
      transposed_matrix = self.class.new
      transposed_matrix._11 = _11
      transposed_matrix._12 = _21
      transposed_matrix._13 = _31
      transposed_matrix._14 = _41
      transposed_matrix._21 = _12
      transposed_matrix._22 = _22
      transposed_matrix._23 = _32
      transposed_matrix._24 = _42
      transposed_matrix._31 = _13
      transposed_matrix._32 = _23
      transposed_matrix._33 = _33
      transposed_matrix._34 = _43
      transposed_matrix._41 = _14
      transposed_matrix._42 = _24
      transposed_matrix._43 = _34
      transposed_matrix._44 = _44
      transposed_matrix
    end

    def print
      puts "_11: #{_11}\n"
      puts "_12: #{_12}\n"
      puts "_13: #{_13}\n"
      puts "_14: #{_14}\n"
      puts "_21: #{_21}\n"
      puts "_22: #{_22}\n"
      puts "_23: #{_23}\n"
      puts "_24: #{_24}\n"
      puts "_31: #{_31}\n"
      puts "_32: #{_32}\n"
      puts "_33: #{_33}\n"
      puts "_34: #{_34}\n"
      puts "_41: #{_41}\n"
      puts "_42: #{_42}\n"
      puts "_43: #{_43}\n"
      puts "_44: #{_44}\n"
    end

    def to_s
      (0..3).to_a.map { |i| row(i).to_s }.join "\n"
    end

    def self.glu_perspective_degrees fovy, aspect, zn, zf
      fovy = fovy.to_f
      aspect = aspect.to_f
      zn = zn.to_f
      zf = zf.to_f
      range = zn*Math.tan(Geo3d::Utils.to_radians(fovy/2.0))
      self.gl_frustum -range*aspect, range*aspect, -range, range, zn, zf
    end

    def self.gl_frustum l, r, bottom, t, zn, zf
      l = l.to_f
      r = r.to_f
      bottom = bottom.to_f
      t = t.to_f
      zn = zn.to_f
      zf = zf.to_f
      a = (r+l) / (r-l)
      b = (t+bottom) / (t-bottom)
      c = -(zf + zn) / (zf - zn)
      d = -(2 * zf * zn) / (zf - zn)
      matrix = self.new
      matrix._11 = 2.0 * zn / (r-l)
      matrix._31 = a
      matrix._22 = 2.0 * zn / (t-bottom)
      matrix._32 = b
      matrix._33 = c
      matrix._43 = d
      matrix._34 = -1.0
      matrix
    end


    def self.perspective_fov_rh fovy, aspect, zn, zf
      fovy = fovy.to_f
      aspect = aspect.to_f
      zn = zn.to_f
      zf = zf.to_f
      y_scale = 1.0 / Math.tan(0.5*fovy)
      x_scale = y_scale / aspect
      matrix = self.new
      matrix._11 = x_scale
      matrix._22 = y_scale
      matrix._33 = zf/(zn - zf)
      matrix._34 = -1
      matrix._43 = zn*zf/(zn - zf)
      matrix
    end

    def self.perspective_fov_lh fovy, aspect, zn, zf
      fovy = fovy.to_f
      aspect = aspect.to_f
      zn = zn.to_f
      zf = zf.to_f
      y_scale = 1.0 / Math.tan(0.5*fovy)
      x_scale = y_scale / aspect
      matrix = self.new
      matrix._11 = x_scale
      matrix._22 = y_scale
      matrix._33 = zf/(zf - zn)
      matrix._34 = 1
      matrix._43 = zn*zf/(zn - zf)
      matrix
    end

    def self.gl_ortho l, r, b, t, zn, zf
      l = l.to_f
      r = r.to_f
      b = b.to_f
      t = t.to_f
      zn = zn.to_f
      zf = zf.to_f
      matrix = self.new
      matrix._11 = 2.0 / (r-l)
      matrix._22 = 2.0 / (t-b)
      matrix._33 = -2.0 / (zf - zn)
      matrix._41 = -(r+l) / (r-l)
      matrix._42 = -(t+b) / (t-b)
      matrix._43 = -(zf+zn) / (zf-zn)
      matrix._44 = 1.0
      matrix
    end

    def self.ortho_off_center_rh l, r, b, t, zn, zf
      l = l.to_f
      r = r.to_f
      b = b.to_f
      t = t.to_f
      zn = zn.to_f
      zf = zf.to_f
      m = identity
      m._11 = 2.0 / (r - l)
      m._22 = 2.0 / (t - b)
      m._33 = 1.0 / (zn -zf)
      m._41 = -1.0 -2.0 *l / (r - l)
      m._42 = 1.0 + 2.0 * t / (b - t)
      m._43 = zn / (zn -zf)
      m
    end

    def self.ortho_off_center_lh l, r, b, t, zn, zf
      l = l.to_f
      r = r.to_f
      b = b.to_f
      t = t.to_f
      zn = zn.to_f
      zf = zf.to_f
      m = identity
      m._11 = 2.0 / (r - l)
      m._22 = 2.0 / (t - b)
      m._33 = 1.0 / (zf -zn)
      m._41 = -1.0 -2.0 *l / (r - l)
      m._42 = 1.0 + 2.0 * t / (b - t)
      m._43 = zn / (zn -zf)
      m
    end

    def self.look_at_rh eye_position, look_at_position, up_direction
      zaxis = (eye_position - look_at_position).normalize
      xaxis = up_direction.cross(zaxis).normalize
      yaxis = zaxis.cross xaxis

      matrix = self.new

      # set column one
      matrix._11 = xaxis.x
      matrix._21 = xaxis.y
      matrix._31 = xaxis.z
      matrix._41 = -xaxis.dot(eye_position)

      # set column two
      matrix._12 = yaxis.x
      matrix._22 = yaxis.y
      matrix._32 = yaxis.z
      matrix._42 = -yaxis.dot(eye_position)

      # set column three
      matrix._13 = zaxis.x
      matrix._23 = zaxis.y
      matrix._33 = zaxis.z
      matrix._43 = -zaxis.dot(eye_position)

      # set column four
      matrix._14 = matrix._24 = matrix._34 = 0
      matrix._44 = 1

      matrix
    end

    def self.look_at_lh eye_position, look_at_position, up_direction
      zaxis = (look_at_position - eye_position).normalize
      xaxis = up_direction.cross(zaxis).normalize
      yaxis = zaxis.cross xaxis

      matrix = self.new

      # set column one
      matrix._11 = xaxis.x
      matrix._21 = xaxis.y
      matrix._31 = xaxis.z
      matrix._41 = -xaxis.dot(eye_position)

      # set column two
      matrix._12 = yaxis.x
      matrix._22 = yaxis.y
      matrix._32 = yaxis.z
      matrix._42 = -yaxis.dot(eye_position)

      # set column three
      matrix._13 = zaxis.x
      matrix._23 = zaxis.y
      matrix._33 = zaxis.z
      matrix._43 = -zaxis.dot(eye_position)

      # set column four
      matrix._14 = matrix._24 = matrix._34 = 0
      matrix._44 = 1

      matrix
    end


    def self.viewport x, y, width, height
      self.scaling(width.to_f / 2.0, height.to_f / 2.0, 0.5) * self.translation(x.to_f + width.to_f / 2.0, y.to_f + height.to_f / 2.0, 0.5)
    end

    def self.reflection reflection_plane
      reflection_plane = Geo3d::Vector.new *reflection_plane.to_a
      reflection_matrix = self.new

      plane_magnitude = Vector.new(reflection_plane.x, reflection_plane.y, reflection_plane.z, 0).length
      normalized_plane = reflection_plane / plane_magnitude

      # row one
      reflection_matrix._11 = -2 * normalized_plane.x * normalized_plane.x + 1
      reflection_matrix._12 = -2 * normalized_plane.y * normalized_plane.x
      reflection_matrix._13 = -2 * normalized_plane.z * normalized_plane.x
      reflection_matrix._14 = 0

      # row two
      reflection_matrix._21 = -2 * normalized_plane.x * normalized_plane.y
      reflection_matrix._22 = -2 * normalized_plane.y * normalized_plane.y + 1
      reflection_matrix._23 = -2 * normalized_plane.z * normalized_plane.y
      reflection_matrix._24 = 0

      # row three
      reflection_matrix._31 = -2 * normalized_plane.x * normalized_plane.z
      reflection_matrix._32 = -2 * normalized_plane.y * normalized_plane.z
      reflection_matrix._33 = -2 * normalized_plane.z * normalized_plane.z + 1
      reflection_matrix._34 = 0

      # row four
      reflection_matrix._41 = -2 * normalized_plane.x * normalized_plane.w
      reflection_matrix._42 = -2 * normalized_plane.y * normalized_plane.w
      reflection_matrix._43 = -2 * normalized_plane.z * normalized_plane.w
      reflection_matrix._44 = 1

      reflection_matrix
    end

    def self.shadow light_position, plane
      plane = Geo3d::Vector.new *plane.to_a
      norm = plane.x * plane.x + plane.y * plane.y + plane.z * plane.z
      normalized_plane = plane / norm
      dot = normalized_plane.dot(light_position)

      m = self.new
      m._11 = dot - normalized_plane.a * light_position.x
      m._12 = -normalized_plane.a * light_position.y
      m._13 = -normalized_plane.a * light_position.z
      m._14 = -normalized_plane.a * light_position.w
      m._21 = -normalized_plane.b * light_position.x
      m._22 = dot - normalized_plane.b * light_position.y
      m._23 = -normalized_plane.b * light_position.z
      m._24 = -normalized_plane.b * light_position.w
      m._31 = -normalized_plane.c * light_position.x
      m._32 = -normalized_plane.c * light_position.y
      m._33 = dot - normalized_plane.c * light_position.z
      m._34 = -normalized_plane.c * light_position.w
      m._41 = -normalized_plane.d * light_position.x
      m._42 = -normalized_plane.d * light_position.y
      m._43 = -normalized_plane.d * light_position.z
      m._44 = dot - normalized_plane.d * light_position.w

      m
    end


    def self.translation x, y, z
      translation_matrix = self.new
      translation_matrix._11 = translation_matrix._22 = translation_matrix._33 = translation_matrix._44 = 1.0
      #todo: consider simplifying with identity
      translation_matrix._41 = x.to_f
      translation_matrix._42 = y.to_f
      translation_matrix._43 = z.to_f
      translation_matrix
    end

    def self.scaling x, y, z
      scaling_matrix = self.new
      scaling_matrix._11 = x.to_f
      scaling_matrix._22 = y.to_f
      scaling_matrix._33 = z.to_f
      scaling_matrix._44 = 1.0
      scaling_matrix
    end

    def self.uniform_scaling scale
      scaling scale, scale, scale
    end

    def self.rotation_x angle
      m = identity
      sine = Math.sin angle
      cosine = Math.cos angle
      m._22 = cosine
      m._33 = cosine
      m._23 = sine
      m._32 = -sine
      m
    end

    def self.rotation_y angle
      m = identity
      sine = Math.sin angle
      cosine = Math.cos angle
      m._11 = cosine
      m._33 = cosine
      m._13 = -sine
      m._31 = sine
      m
    end

    def self.rotation_z angle
      m = identity
      sine = Math.sin angle
      cosine = Math.cos angle
      m._11 = cosine
      m._22 = cosine
      m._12 = sine
      m._21 = -sine
      m
    end

    def self.rotation axis, angle
      v = axis.normalize
      m = identity
      m._11 = (1.0 - Math.cos(angle)) * v.x * v.x + Math.cos(angle)
      m._21 = (1.0 - Math.cos(angle)) * v.x * v.y - Math.sin(angle) * v.z
      m._31 = (1.0 - Math.cos(angle)) * v.x * v.z + Math.sin(angle) * v.y
      m._12 = (1.0 - Math.cos(angle)) * v.y * v.x + Math.sin(angle) * v.z
      m._22 = (1.0 - Math.cos(angle)) * v.y * v.y + Math.cos(angle)
      m._32 = (1.0 - Math.cos(angle)) * v.y * v.z - Math.sin(angle) * v.x
      m._13 = (1.0 - Math.cos(angle)) * v.z * v.x - Math.sin(angle) * v.y
      m._23 = (1.0 - Math.cos(angle)) * v.z * v.y + Math.sin(angle) * v.x
      m._33 = (1.0 - Math.cos(angle)) * v.z * v.z + Math.cos(angle)
      m
    end
  end
end