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
a = Geo3d::Vector.new 1, 0, 0
b = Geo3d::Vector.new 0, 1, 0
sum = a + b # add them together
sum *= 2 #double the vector

m = Geo3d::Matrix.translation 0, 5, 0 #create a translation matrix that transforms a points 5 units on the y-axis
sum = m * sum #apply the transform to our vector
```


## Vector

Describes a three dimensional point or direction. A vector has the following read/write attributes: x, y, z, w

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

mat_a + mat_b   #addition

mat_a - mat_b   #subtraction

mat * scalar  #scalar multiplication

mat / scalar  #scalar division

mat_a * mat_b #matrix multiplication

mat * vec  #matrix vector multiplication


Additional matrix operations
mat.inverse #returns inverse of matrix
mat.inverse true  #returns inverse of matrix along with its determinant
mat.tranpose #returns transpose of matrix

Common matrix constructors
Geo3d::Matrix.identity  #returns the identity matrix
Geo3d::Matrix.translation x,y,z  #returns a translation matrix
Geo3d::Matrix.scaling x,y,z #returns a scaling matrix
Geo3d::Matrix.uniform_scaling scale #returns a uniform scaling matrix

Projection matrix constructors
Geo3d::Matrix.matrix_perspective_fov_rh fovy, aspect, z_near, z_far  #returns a right handed perspective projection matrix
Geo3d::Matrix.matrix_perspective_fov_lh fovy, aspect, z_near, z_far  #returns a left handed perspective projection matrix

View matrix constructors
Geo3d::Matrix.look_at_rh eye_position, look_at_position, up_direction #returns a right handed view matrix
Geo3d::Matrix.look_at_lh eye_position, look_at_position, up_direction #returns a left handed view matrix

Misc constructors
Geo3d::Matrix.reflection reflection_plane  #returns a reflection matrix where reflection_plane is a Geo3d::Vector that corresponds to the normal of the plane









## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
