# Geo3d

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'geo3d'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install geo3d

## Usage
```
a = Geo3d::Vector.point 1, 0, 0
b = Geo3d::Vector.point 0, 1, 0
sum = a + b # add them together
sum *= 2 #double the vector

m = Geo3d::Matrix.translation 0, 5, 0, #create a translation matrix that transforms a points 5 units on the y-axis
sum = m * sum #apply the transform to our vector
```


## Vector

Describes a three dimensional point or direction. A vector has the following read/write attributes: x, y, z, w

Constructors
```
    a = Geo3d::Vector.new #all attributes are initialized to zero
    b = Geo3d::Vector.new x,y,z,w  #initialize all attributes directly
    c = Geo3d::Vector.new x,y,z   #initialize x,y, and z directly and default w to zero
    d = Geo3d::Vector.point x,y,z  #initialize x,y, and z directly and default w to one
    e = Geo3d::Vector.direction x,y,z  #initialize x,y, and z directly and default w to zero
```

Vectors are overloaded with all of the basic math operations.

Addition
```
    vec_a + vec_b
```
Subtraction
```
    vec_a - vec_b
```
Multiplication
```
    vec * scalar
```
Division
```
    vec / scalar
```

Additional vector operations

Dot product
```
    vec.dot
```
Cross product
```
vec_a.cross vec_b
```
Magnitude
```
    vec.length
```
Squared Magnitude
```
    vec.length_squared
```
Normalize
```
    vec.normalize #returns a normalized version of the vector
    vec.normalize! #normalizes the vector in place
```
Linear Interpolation
```
    vec_a.lerp vec_b, 0.4  #returns a new vector which is the 40% linear interpolation between vec_a and vec_b
```


## Matrix

A 4x4 matrix used for transforming vectors. Elements can be read/written to with the double subscription operation.
For instance, matrix[0,1] = 7 writes seven to the element in column zero and row one.

Matrices are overloaded with all of the basic math operations

Addition
```
    mat_a + mat_b
```
Subtraction
```
    mat_a - mat_b
```
Scalar Multiplication
```
    mat * scalar
```
Scalar Division
```
    mat / scalar
```
Matrix Multiplication
```
    mat_a * mat_b
```
Matrix Vector Multiplication
```
    mat * vec
```


Additional matrix operations

Inverse
```
    mat.inverse #returns inverse of matrix
    mat.inverse true  #returns inverse of matrix along with its determinant
    mat.determinant #returns the determinant
```
Transpose
```
    mat.transpose
```

Common matrix constructors

Identity
```
    Geo3d::Matrix.identity  #returns the identity matrix
```
Translation
```
    Geo3d::Matrix.translation x,y,z  #returns a translation matrix
```
Scaling
```
    Geo3d::Matrix.scaling x,y,z #returns a scaling matrix
    Geo3d::Matrix.uniform_scaling scale #returns a uniform scaling matrix
```
Rotation
```
    Geo3d::Matrix.rotation_x 0.44 #rotate .44 radians about x axis
    Geo3d::Matrix.rotation_y 0.44 #rotate .44 radians about y axis
    Geo3d::Matrix.rotation_z 0.44 #rotate .44 radians about z axis

    axis = Geo3d::Vector.new 1,1,0
    angle = 0.9
    Geo3d::Matrix.rotation axis, angle #rotate about an arbitrary axis
```
Projection matrix constructors ala Direct3D   (clip space has a range of 0 to 1)
```
    Geo3d::Matrix.perspective_fov_rh fovy, aspect, z_near, z_far  #returns a right handed perspective projection matrix
    Geo3d::Matrix.perspective_fov_lh fovy, aspect, z_near, z_far  #returns a left handed perspective projection matrix
    Geo3d::Matrix.ortho_off_center_rh left, right, bottom, top, z_near, z_far #returns a right handed orthographic projection matrix
    Geo3d::Matrix.ortho_off_center_lh left, right, bottom, top, z_near, z_far #returns a left handed orthographic projection matrix
```
Projection matrix constructors ala OpenGL  (clip space has a range of -1 to 1)
```
    Geo3d::Matrix.glu_perspective_degrees fovy, aspect, zn, zf #returns an opengl style right handed projection matrix
```
View matrix constructors
```
    Geo3d::Matrix.look_at_rh eye_position, look_at_position, up_direction #returns a right handed view matrix
    Geo3d::Matrix.look_at_lh eye_position, look_at_position, up_direction #returns a left handed view matrix
```
Misc constructors
```
    Geo3d::Matrix.reflection reflection_plane  #returns a reflection matrix where reflection_plane is a Geo3d::Vector that corresponds to the normal of the plane
    Geo3d::Matrix.shadow light_position, plane  #returns a shadow matrix
```
Matrix Decomposition
```
    matrix.scaling_component
    matrix.translation_component
    matrix.rotation_component
```

## Plane

Represents a 2d surface in three dimensional space. Has the attributes a,b,c,d that mirror the standard plane equations.

There are a couple constructors to build planes from points and normals.
````
Geo3d::Plane.from_points pv1, pv2, pv3  #builds a plane from known points on the plane
Geo3d::Plane.from_point_and_normal point, normal  #builds a plane from it's normal and a known point
````

Additional plane operations

Dot product
```
    plane.dot v  #v can be a vector or another plane
```
Normalize
```
    plane.normalize #returns a normalized version of the plane
    plane.normalize! #normalizes the plane in place
```
Line intersection
```
    plane.line_intersection line_start, line_end  #returns the intersection of the line onto the plane
````
Plane Transformation
````
    #transforms plane by the matrix, if use_inverse_transpose is set to true, the plane will be transformed by the inverse transpose of matrix
    plane.transform matrix, use_inverse_transpose = true
````


## Quaternion

A mathematical construct to represent rotations in 3d space.

Quaternions support all the basic math operations.

Addition
```
    quat_a + quat_b
```
Subtraction
```
    quat_a - quat_b
```
Quaternion Multiplication
```
    quat_a * quat_b
```
Scalar Multiplication
```
    quat * scalar
```
Scalar Division
```
    quat / scalar
```
Getting axis and angle
```
    quat.axis
    quat.angle          #returns angle in radians
    quat.angle_degrees  #returns angle in degrees
```
Converting to a matrix
```
    quat.to_matrix
```

Additional quaternion operations
Magnitude
```
    quat.length
```
Squared Magnitude
```
    quat.length_squared
```
Normalize
```
    quat.normalize #returns a normalized version of the quaternion
    quat.normalize! #normalizes the quaternion in place
```
Inverse
```
    quat.inverse #returns inverse of quaternion
```
Conjugate
```
    quat.conjugate
```
Dot product
```
    quat.dot
```

Constructors
```
    Geo3d::Quaternion.from_axis rotation_axis, radians  #returns a quaternion from an axis and angle
    Geo3d::Quaternion.from_matrix m  #returns a quaternion from a rotation matrix
    Geo3d::Quaternion.identity  #returns the identity quaternion

```

Documentation coming soon!








## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
